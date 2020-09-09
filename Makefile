MAKEFLAGS += --warn-undefined-variables -j1
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:
.PHONY:

# Environment switches
MAKE_ENV ?= docker
COMPOSE_RUN_SHELL_FLAGS ?= --rm

# Directories
VENDOR_DIR ?= vendor/bundle
GEMFILES_DIR ?= gemfiles

# Host binaries
AWK ?= awk
BASH ?= bash
COMPOSE ?= docker-compose
DOCKER ?= docker
GREP ?= grep
ID ?= id
MKDIR ?= mkdir
RM ?= rm
XARGS ?= xargs

# Container binaries
BUNDLE ?= bundle
APPRAISAL ?= appraisal
GEM ?= gem
RAKE ?= rake
YARD ?= yard
RAKE ?= rake
RUBOCOP ?= rubocop

# Files
GEMFILES ?= $(subst _,-,$(patsubst $(GEMFILES_DIR)/%.gemfile,%,\
	$(wildcard $(GEMFILES_DIR)/*.gemfile)))
TEST_GEMFILES := $(GEMFILES:%=test-%)

# Define a generic shell run wrapper
# $1 - The command to run
ifeq ($(MAKE_ENV),docker)
define run-shell
	$(COMPOSE) run $(COMPOSE_RUN_SHELL_FLAGS) \
		-e LANG=en_US.UTF-8 -e LANGUAGE=en_US.UTF-8 -e LC_ALL=en_US.UTF-8 \
		-e HOME=/home/web -e BUNDLE_APP_CONFIG=/app/.bundle \
		-u `$(ID) -u` test bash -c 'sleep 0.1; echo; $(1)'
endef
else ifeq ($(MAKE_ENV),baremetal)
define run-shell
	$(1)
endef
endif

all:
	# Immoscout
	#
	# install            Install the dependencies
	# test               Run the whole test suite
	# clean              Clean the dependencies
	#
	# shell              Run an interactive shell on the container
	# shell-irb          Run an interactive IRB shell on the container

install:
	# Install the dependencies
	@$(MKDIR) -p $(VENDOR_DIR)
	@$(call run-shell,$(BUNDLE) check || $(BUNDLE) install --path $(VENDOR_DIR))
	@$(call run-shell,GEM_HOME=vendor/bundle/ruby/$${RUBY_MAJOR}.0 \
		$(GEM) install bundler -v "~> 1.0")
	@$(call run-shell,$(BUNDLE) exec $(APPRAISAL) install)

update: install
	# Install the dependencies
	@$(MKDIR) -p $(VENDOR_DIR)
	@$(call run-shell,$(BUNDLE) exec $(APPRAISAL) update)

test: #install
	# Run the whole test suite
	@$(call run-shell,$(BUNDLE) exec $(RAKE))

$(TEST_GEMFILES): GEMFILE=$(@:test-%=%)
$(TEST_GEMFILES):
	# Run the whole test suite ($(GEMFILE))
	@$(call run-shell,$(BUNDLE) exec $(APPRAISAL) $(GEMFILE) $(RAKE))

test-style: \
	test-style-ruby

test-style-ruby:
	# Run the static code analyzer (rubocop)
	@$(call run-shell,$(BUNDLE) exec $(RUBOCOP) -a)

clean:
	# Clean the dependencies
	@$(RM) -rf $(VENDOR_DIR)
	@$(RM) -rf $(VENDOR_DIR)/Gemfile.lock
	@$(RM) -rf $(GEMFILES_DIR)/vendor
	@$(RM) -rf $(GEMFILES_DIR)/*.lock
	@$(RM) -rf pkg
	@$(RM) -rf coverage

clean-containers:
	# Clean running containers
ifeq ($(MAKE_ENV),docker)
	@$(COMPOSE) down
endif

clean-images:
	# Clean build images
ifeq ($(MAKE_ENV),docker)
	@-$(DOCKER) images | $(GREP) immoscout \
		| $(AWK) '{ print $$3 }' \
		| $(XARGS) -rn1 $(DOCKER) rmi -f
endif

distclean: clean clean-containers clean-images

shell: install
	# Run an interactive shell on the container
	@$(call run-shell,$(BASH) -i)

shell-irb: install
	# Run an interactive IRB shell on the container
	@$(call run-shell,bin/console)

docs: install
	# Build the API documentation
	@$(call run-shell,$(BUNDLE) exec $(YARD) -q && \
		$(BUNDLE) exec $(YARD) stats --list-undoc --compact)

release:
	# Release a new gem version
	@$(RAKE) release

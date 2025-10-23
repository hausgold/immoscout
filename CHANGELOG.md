### next

* TODO: Replace this bullet point with an actual description of a change.

### 2.1.0 (23 October 2025)

* Dropped Reek ([#23](https://github.com/hausgold/immoscout/pull/23))
* Added support for Rails 8.1 ([#24](https://github.com/hausgold/immoscout/pull/24))
* Switched from `ActiveSupport::Configurable` to a custom implementation based
  on `ActiveSupport::OrderedOptions` ([#25](https://github.com/hausgold/immoscout/pull/25))

### 2.0.0 (28 June 2025)

* Corrected some RuboCop glitches ([#21](https://github.com/hausgold/immoscout/pull/21))
* Drop Ruby 2 and end of life Rails (<7.1) ([#22](https://github.com/hausgold/immoscout/pull/22))

### 1.9.1 (21 May 2025)

* Corrected some RuboCop glitches ([#18](https://github.com/hausgold/immoscout/pull/18))
* Upgraded the rubocop dependencies ([#19](https://github.com/hausgold/immoscout/pull/19))
* Corrected some RuboCop glitches ([#20](https://github.com/hausgold/immoscout/pull/20))

### 1.9.0 (30 January 2025)

* Added all versions up to Ruby 3.4 to the CI matrix ([#17](https://github.com/hausgold/immoscout/pull/17))

### 1.8.1 (17 January 2025)

* Added the logger dependency ([#16](https://github.com/hausgold/immoscout/pull/16))

### 1.8.0 (12 January 2025)

* Switched to Zeitwerk as autoloader ([#15](https://github.com/hausgold/immoscout/pull/15))

### 1.7.0 (3 January 2025)

* Raised minimum supported Ruby/Rails version to 2.7/6.1 ([#14](https://github.com/hausgold/immoscout/pull/14))

### 1.6.5 (15 August 2024)

* Just a retag of 1.6.1

### 1.6.4 (15 August 2024)

* Just a retag of 1.6.1

### 1.6.3 (15 August 2024)

* Just a retag of 1.6.1

### 1.6.2 (9 August 2024)

* Just a retag of 1.6.1

### 1.6.1 (9 August 2024)

* Added API docs building to continuous integration ([#13](https://github.com/hausgold/immoscout/pull/13))

### 1.6.0 (8 July 2024)

* Moved the development dependencies from the gemspec to the Gemfile ([#11](https://github.com/hausgold/immoscout/pull/11))
* Dropped support for Ruby <2.7 ([#12](https://github.com/hausgold/immoscout/pull/12))

### 1.5.0 (24 February 2023)

* Added support for Gem release automation

### 1.4.0 (18 January 2023)

* Bundler >= 2.3 is from now on required as minimal version ([#10](https://github.com/hausgold/immoscout/pull/10))
* Dropped support for Ruby < 2.5 ([#10](https://github.com/hausgold/immoscout/pull/10))
* Dropped support for Rails < 5.2 ([#10](https://github.com/hausgold/immoscout/pull/10))
* Updated all development/runtime gems to their latest
  Ruby 2.5 compatible version ([#10](https://github.com/hausgold/immoscout/pull/10))

### 1.3.2 (15 October 2021)

* Migrated to Github Actions
* Migrated to our own coverage reporting
* Added the code statistics to the test process

### 1.3.1 (12 May 2021)

* Corrected the GNU Make release target

### 1.3.0 (9 September 2020)

* Dropped support for Rails <5.2 ([#9](https://github.com/hausgold/immoscout/pull/9))
* Dropped support for Ruby <2.5 ([#9](https://github.com/hausgold/immoscout/pull/9))
* Updated the faraday gem spec to `~> 1.0` ([#9](https://github.com/hausgold/immoscout/pull/9))

### 1.2.0 (6 March 2019)

* Added a changelog file to track changes for library users
* Allow newer version of faraday/faraday-middleware. ([#7](https://github.com/hausgold/immoscout/pull/7))
* Set `HausgoldImmoscout/#{gem_version}` as user agent
* Set correct content type and filename for mixed multipart ([#5](https://github.com/hausgold/immoscout/pull/5))
* Dropped support for EOL Ruby 2.2
* Added support for Ruby 2.6

### 1.1.0 (6 September 2018)

* Add support for property `international_country_region` in address

### 1.0.0 (9 May 2018)

* The first stable release
* All initial Immoscout models are mapped

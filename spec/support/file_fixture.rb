# frozen_string_literal: true

module FileFixture
  def file_fixture(name)
    File.open("#{ENV.fetch('PWD')}/spec/fixtures/files/#{name}")
  end
end

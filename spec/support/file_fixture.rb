# frozen_string_literal: true

module FileFixture
  def file_fixture(name)
    File.open(File.join(__dir__, "../fixtures/files/#{name}"))
  end
end

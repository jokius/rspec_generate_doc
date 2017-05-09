require 'rspec/rails'
require 'rspec_generate_doc/configuration'
require 'rspec_generate_doc/library_hooks/doc'

module RspecGenerateDoc
  extend self

  I18n.load_path.concat Dir[File.expand_path('../../config/locales/*.yml', __FILE__)]

  ::RSpec.configure do |config|
    config.include RspecGenerateDoc::LibraryHooks::Doc, type: :controller
  end

  def configure
    yield configuration
  end

  def configuration
    @configuration ||= Configuration.new
  end
end

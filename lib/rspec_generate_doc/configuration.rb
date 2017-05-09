require 'rspec_generate_doc/decorators/action'
require 'rspec_generate_doc/decorators/parameter'

module RspecGenerateDoc
  class Configuration
    attr_writer :docs_dir, :locale, :action_decorator, :parameter_decorator, :template_file, :file_prefix, :file_suffix

    def docs_dir
      @docs_dir || "#{Rails.root}/docs"
    end

    def locale
      @locale || I18n.default_locale
    end

    def action_decorator
      @action_decorator || RspecGenerateDoc::Decorators::Action
    end

    def parameter_decorator
      @parameter_decorator || RspecGenerateDoc::Decorators::Parameter
    end

    def template_file
      @template_file || "#{File.dirname(__FILE__)}/templates/slate.md.erb"
    end

    def file_prefix
      @file_prefix || '_'
    end

    def file_suffix
      @file_suffix || ''
    end
  end
end

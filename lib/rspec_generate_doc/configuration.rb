require 'fileutils'

module RspecGenerateDoc
  class Configuration
    def docs_dir
      @docs_dir || "#{Rails.root}/docs"
    end

    def docs_dir=(dir)
      @docs_dir = dir
    end

    def locale
      @locale || I18n.default_locale
    end

    def locale=(locale)
      @locale = locale
    end
  end
end

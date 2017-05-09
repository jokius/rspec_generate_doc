require 'erb'
require 'fileutils'

module RspecGenerateDoc
  class GenarateFIle
    TEMPLATE_EXTNAME = 'erb'.freeze

    attr_reader :actions, :parent

    def initialize(data = {})
      @actions = data[:actions]
      @parent = data[:parent]
      I18n.locale = configuration.locale
    end

    def self.source_root
      configuration.docs_dir
    end

    def create_file_by_template
      file = File.open(file_path, 'w+')
      file.write ERB.new(File.binread(configuration.template_file), nil, '-').result(binding)
      file.close
    end

    private

    def file_path
      "#{dir}/#{configuration.file_prefix}#{parent_name}#{configuration.file_suffix}.#{file_extension}"
    end

    def parent_name
      @parent_name ||= parent.downcase.split('::').join('_')
    end

    def template_name
      @template_name ||= configuration.template_file.split('/').last
    end

    def file_extension
      @file_extension ||= template_name.sub(/#{TEMPLATE_EXTNAME}$/, "").split('.').last
    end

    def dir
      @dir ||= FileUtils.mkdir_p(configuration.docs_dir).join('')
    end

    def configuration
      @configuration ||= RspecGenerateDoc.configuration
    end
  end
end

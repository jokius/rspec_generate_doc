require 'fileutils'

module RspecGenerateDoc
  class Genarate
    attr_reader :parent, :methods_hash

    def initialize(parent, methods_hash)
      @parent = parent
      @methods_hash = methods_hash
      I18n.locale = RspecGenerateDoc.configuration.locale
      create_file
    end

    private

    def dir
      @dir ||= FileUtils.mkdir_p(RspecGenerateDoc.configuration.docs_dir).join('')
    end

    def create_file
      file = File.open("#{dir}/_#{parent_name}.md", 'w+')
      file.write file_text
      file.close
    end

    def parent_name
      @parent_name ||= parent.downcase.split('::').join('_')
    end

    def file_text
      file_text = "# #{parent}\r\n\r\n"
      methods_hash.each do |key, method|
        response = method[:response]
        request = response.request
        file_text += "##{key.split('#').join(' ')}\r\n\r\n"\
                  "```http\r\n"\
                  "#{request.request_method} #{request.original_fullpath.split('?').first} HTTP/1.1\r\n"\
                  "Host: #{response.request.host}\r\n"\
                  "User-Agent: ExampleClient/1.0.0\r\n"\
                  "```\r\n\r\n"\
                  "```http\r\n"\
                  "HTTP/1.1 #{response.status} #{response.status_message}\r\n"
        file_text += "Content-Type: #{response.content_type}\r\n\r\n" if response.content_type.present?
        if response.body.present?
          object = begin
                     JSON.parse(response.body)
                   rescue
                     nil
                   end
          body = object.nil? ? response.body : JSON.pretty_generate(object)
          file_text += "#{body}\r\n" if response.body.present?
        end

        file_text += "```\r\n\r\n"\
                  "#{I18n.t(:parameter, scope: :rspec_api_docs)} | #{I18n.t(:required, scope: :rspec_api_docs)} | #{I18n.t(:description, scope: :rspec_api_docs)}\r\n"\
                  "-------- | ------- | -------\r\n"
        file_text += params_to_text(request, method[:api_params])
        file_text += "\r\n\r\n"
      end

      file_text
    end

    def params_to_text(_request, api_params)
      file_text = ''

      api_params.keys.each do |name|
        hash = api_params[name.to_sym] || {}
        hash = {} unless hash.is_a? Hash
        required = if hash[:required]
                     I18n.t(:required_yes, scope: :rspec_api_docs)
                   else
                     I18n.t(:required_no, scope: :rspec_api_docs)
                   end

        description = hash[:description] || name
        file_text += "#{name} | #{required} | #{description}\r\n"
      end

      file_text
    end
  end
end

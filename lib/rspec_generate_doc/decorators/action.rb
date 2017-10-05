require 'ostruct'

module RspecGenerateDoc
  module Decorators
    class Action
      attr_reader :name, :response, :content_type, :status, :status_message,
                  :host, :request_method, :request_fullpath, :params, :options
      def initialize(data = {})
        @name = (data[:name] || '').split('#').join(' ')
        @response = data[:response]
        @content_type = data[:content_type] || response.content_type
        @status = data[:status] || response.status
        @status_message = data[:status_message] || response.status_message
        @host = data[:host] || request.host
        @request_method = data[:request_method] || request.request_method
        @request_fullpath = data[:request_fullpath] || request.original_fullpath.split('?').first
        @params = to_params(data[:api_params])
        @options = OpenStruct.new(data[:options] || {})
      end

      def status_with_message
        "#{status} #{status_message}"
      end

      def content_type?
        content_type.present?
      end

      def body
        @body ||= json_object.nil? ? response.body.to_s : JSON.pretty_generate(json_object)
      end

      private

      def to_params(api_params)
        api_params.map do |name, value|
          hash = value.is_a?(Hash) ? value : {}
          hash[:name] = name unless hash[:name] || hash['name']
          RspecGenerateDoc.configuration.parameter_decorator.new(hash)
        end
      end

      def json_object
        @json_object ||= JSON.parse(response.body) rescue nil
      end

      def request
        @request ||= response.request
      end
    end
  end
end

require 'ostruct'

module RspecGenerateDoc
  module Decorators
    class Action
      attr_reader :name, :response, :params, :options
      def initialize(data = {})
        @name = (data[:name] || '').split('#').join(' ')
        @response = data[:response]
        @params = to_params(data[:api_params])
        @options = OpenStruct.new(data[:options] || {})
      end

      def request_method
        @request_method ||= request.request_method
      end

      def request_fullpath
        @request_fullpath ||= request.original_fullpath.split('?').first
      end

      def host
        @host ||= request.host
      end

      def status
        @status ||= response.status
      end

      def status_message
        @status_message ||= response.status_message
      end

      def status_with_message
        @status_with_message ||= "#{status} #{status_message}"
      end

      def content_type
        @content_type ||= response.content_type
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

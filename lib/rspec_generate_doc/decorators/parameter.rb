module RspecGenerateDoc
  module Decorators
    class Parameter
      attr_reader :name, :required, :description, :options

      def initialize(data = {})
        @name = data[:name] || data['name']
        @required = data[:required] || data['required'] || false
        @description = data[:description] || data['description'] || name || ''
        @options = OpenStruct.new(data[:options] || data['options'] || {})
      end

      def required_human
        description ? I18n.t(:required_yes, scope: :rspec_api_docs) : I18n.t(:required_no, scope: :rspec_api_docs)
      end
    end
  end
end

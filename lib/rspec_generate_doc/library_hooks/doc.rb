require 'rspec/rails'
require 'rspec_generate_doc/generate'

module RspecGenerateDoc
  module LibraryHooks
    module Doc
      ::RSpec.configure do |config|
        config.before(:context) do
          @methods_hash = {}
          @is_correct_type = self.class.metadata[:type] == :controller
        end

        config.after(:each) do
          next unless @is_correct_type
          key = self.class.description
          parent = self.class.parent
          loop do
            break if parent.nil? || parent.description == self.class.top_level_description
            key = "#{parent.description} #{key}"
            parent = parent.parent
          end

          skip = try(:skip_this) || @skip_this
          @hash[key] ||= { response: response, api_params: (try(:api_params) || @api_params || {}) } unless skip
        end

        config.after(:context) do
          RspecGenerateDoc::Genarate.new(self.class.top_level_description, @hash)
        end
      end
    end
  end
end

require 'rspec/rails'
require 'rspec_generate_doc/generate'

module RspecGenerateDoc
  module LibraryHooks
    module Doc
      ::RSpec.configure do |config|
        config.before(:context) do
          @hash = {}
        end

        config.after(:each) do
          key = self.class.description
          parent = self.class.parent
          loop do
            break if parent.nil? || parent.description == self.class.top_level_description
            key = "#{parent.description} #{key}"
            parent = parent.parent
          end

          @hash[key] ||= { response: response, params: (try(:params) || @params || {}) }
        end

        config.after(:context) do
          RspecGenerateDoc::Genarate.new(self.class.top_level_description, @hash)
        end
      end
    end
  end
end

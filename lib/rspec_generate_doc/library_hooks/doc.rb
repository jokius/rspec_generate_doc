require 'rspec/rails'
require 'rspec_generate_doc/generate_file'
require 'rspec_generate_doc/decorators/action'

module RspecGenerateDoc
  module LibraryHooks
    module Doc
      ::RSpec.configure do |config|
        config.before(:context) do
          @actions = []
          @is_correct_type = self.class.metadata[:type] == :controller
        end

        config.after(:each) do
          next unless @is_correct_type
          name = self.class.description
          parent = self.class.parent
          loop do
            break if parent.nil? || parent.description == self.class.top_level_description
            name = "#{parent.description} #{name}"
            parent = parent.parent
          end

          next if try(:skip_this) || @skip_this
          api_params = try(:api_params) || @api_params || {}
          opntions = try(:api_opntions) || @api_opntions || {}
          new_action = RspecGenerateDoc.configuration.action_decorator
                                      .new(name: name, response: response, api_params: api_params, options: opntions)
          @actions << new_action unless @actions.index { |action| action.name == new_action.name }
        end

        config.after(:context) do
          next unless @is_correct_type
          parent = self.class.top_level_description
          RspecGenerateDoc::GenarateFIle.new(parent: parent, actions: @actions).create_file_by_template
        end
      end
    end
  end
end

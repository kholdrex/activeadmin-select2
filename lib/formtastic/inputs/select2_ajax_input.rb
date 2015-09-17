module Formtastic
  module Inputs

    class Select2AjaxInput < Formtastic::Inputs::SelectInput
      def extra_input_html_options
        {
          :class => 'select2-input ajax',
          :'data-init-id' => @object.send(input_name),
          :'data-init-text' => @object_name
        }
      end
    end

  end
end

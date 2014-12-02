module ActiveAdmin
  module Inputs
    class FilterSelectInput < ::Formtastic::Inputs::SelectInput
      def extra_input_html_options
        {
          :class => 'select2'
        }
      end
    end
  end
end

class Formtastic::Inputs::SelectInput
  def extra_input_html_options
    {
      :class => 'select2',
      :multiple => multiple?
    }
  end
end

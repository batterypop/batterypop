module ActiveAdmin
  module Inputs
    class FilterNumericRangeInput < ::Formtastic::Inputs::StringInput
      include FilterBase

      def to_html
        input_wrapping do
          [ label_html,
            builder.text_field(gt_input_name, input_html_options(gt_input_name)),
            template.content_tag(:span, "-".html_safe, :class => "seperator"),
            builder.text_field(lt_input_name, input_html_options(lt_input_name)),
          ].join("\n").html_safe
        end
      end

      def gt_input_name
        "#{method}_gte"
      end
      alias :input_name :gt_input_name

      def lt_input_name
        "#{method}_lte"
      end

      def input_html_options(input_name = gt_input_name)
        current_value = @object.send(input_name)
         { :size => 10, :id => "#{input_name}_numeric" , :value => current_value}
      end
    end
  end
end
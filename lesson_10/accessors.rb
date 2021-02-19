# frozen_string_literal: true

require_relative 'exeption_classes'

module Accessors
  def attr_accessor_with_history(*attributes)
    attributes.each do |attribute|
      attr_name = attribute.to_s
      attr_hist_name = "#{attr_name}_history"

      # getter
      class_eval("def #{attr_name};@#{attr_name};end")

      # setter
      class_eval %{
        def #{attr_name}=(val)
          # add to history
          @#{attr_hist_name} ||= []
          @#{attr_hist_name} << val

          # set the value itself
          @#{attr_name}=val
        end

        def #{attr_hist_name};@#{attr_hist_name};end

                      }
    end
  end

  def strong_attr_accessor(attribute, class_name)
    attr_name = attribute.to_s

    # getter
    class_eval("def #{attr_name};@#{attr_name};end")

    # setter
    class_eval %{
        def #{attr_name}=(val)
          raise ClassTypeError, "Класс инстанс-переменной не совпадает с классом присваемого значения!" unless val.class == #{class_name}
          @#{attr_name}=val
        end

                      }
  end
end

# frozen_string_literal: true

require_relative 'exeption_classes'

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validation_list
      @validation_list ||= []
    end

    def validate(attribute, validation_type, option = nil)
      validation_list << [attribute, validation_type, option]
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue ValidationTypeError
      false
    end

    private

    def execute_validation(attribute, validation_type, option = nil)
      attribute_value = instance_variable_get("@#{attribute}")
      case validation_type
      when :presence
        validate_presence(attribute_value)
      when :format
        validate_format(attribute_value, option)
      when :type
        validate_type(attribute_value, option)
      end
    end

    def validate_presence(attribute_value)
      raise ValidationTypeError, 'Атрибут не может быть пустой строкой или nil!' if attribute_value.nil? || attribute_value.to_s.empty?
    end

    def validate_format(attribute_value, option)
      raise ValidationTypeError, 'Атрибут не соответствует заданному регулярному выражению!' if attribute_value.to_s !~ option
    end

    def validate_type(attribute_value, option)
      raise ValidationTypeError, 'Класс атрибута не совпадает с заданным классом!' if attribute_value.class != option
    end

    def validate!
      self.class.validation_list.each { |validation| execute_validation(*validation) }
    end
  end
end
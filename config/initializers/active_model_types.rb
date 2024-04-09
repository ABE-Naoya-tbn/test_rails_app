ActiveModel::Type::Value.prepend(
  Module.new do
    def initialize(precision: nil, limit: nil, scale: nil, array: false, array_compact: true)
      super(precision:, limit:, scale:)
      @array = array
      @array_compact = array_compact
    end

    def array?
      !!@array
    end

    def array_compact?
      !!@array_compact
    end

    def cast(value)
      return if value.nil?

      if array?
        cast_array(value)
      else
        cast_value(value)
      end
    end

    private

    def cast_array(values)
      values = Array.wrap(values).map do |value|
        cast_value(value) unless value.nil?
      end
      if array_compact?
        values.compact
      else
        values
      end
    end
  end
)

module ActiveModel
  module Type
    class SymbolType < ActiveModel::Type::Value
      def type
        :symbol
      end

      private

      def cast_value(value)
        if value.is_a?(::Symbol)
          value
        else
          begin
            value.to_sym
          rescue ArgumentError
            nil
          end
        end
      end
    end
  end
end

module ActiveModel
  module Type
    class HashType < ActiveModel::Type::Value
      def type
        :hash
      end

      private

      def cast_value(value)
        if value.is_a?(::Hash)
          value
        else
          begin
            value.to_h
          rescue ArgumentError
            nil
          end
        end
      end
    end
  end
end

module ActiveModel
  module Type
    class ObjectType < ActiveModel::Type::Value
      attr_reader :class_name

      def initialize(class_name:, precision: nil, limit: nil, scale: nil, array: false)
        super(precision:, limit:, scale:, array:)
        @class_name = class_name
      end

      def type
        :object
      end

      private

      def cast_value(value)
        if value.is_a?(class_name.constantize)
          value
        else
          begin
            class_name.constantize.new(value)
          rescue ArgumentError
            nil
          end
        end
      end
    end
  end
end

ActiveModel::Type.register(:symbol, ActiveModel::Type::SymbolType)
ActiveModel::Type.register(:hash, ActiveModel::Type::HashType)
ActiveModel::Type.register(:object, ActiveModel::Type::ObjectType)
ActiveRecord::Type.register(:symbol, ActiveModel::Type::SymbolType)
ActiveRecord::Type.register(:hash, ActiveModel::Type::HashType)
ActiveRecord::Type.register(:object, ActiveModel::Type::ObjectType)

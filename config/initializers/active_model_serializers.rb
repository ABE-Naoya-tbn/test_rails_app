module ActiveModelSerializers
  module Adapter
    class CustomJson < Base
      def serializable_hash(options = nil)
        options = serialization_options(options)
        serialized_hash = serialize_hash(options)
        serialized_hash = { root => serialized_hash } unless options[:root] == false
        serialized_hash.merge!(serialize_optional_data(options))

        self.class.transform_key_casing!(serialized_hash, instance_options)
      end

      private

      def serialize_hash(options)
        Attributes.new(serializer, instance_options).serializable_hash(options)
      end

      def serialize_optional_data(options)
        resource_option = options.merge(adapter: :custom_json)
        options.fetch(:serialize_with, []).inject({}) do |hash, data|
          hash.merge!(SerializableResource.new(data[:resource], resource_option.merge(data.except(:resource))).as_json)
        end
      end
    end
  end
end

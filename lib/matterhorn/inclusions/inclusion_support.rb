module Matterhorn
  module Inclusions
    module InclusionSupport
      extend ActiveSupport::Concern
      include InheritableAccessors::InheritableHashAccessor

      included do
        inheritable_hash_accessor :__inclusion_configs
      end

      def inclusions(options={})
        @__inclusions__ ||= InclusionSet.new(__inclusion_configs, options.merge(context: self))
      end

      def links
        inclusions
      end

      module ClassMethods

        def add_inclusion(name, options={}, &block)
          name = name.to_sym
          raise ArgumentError, 'inclusion already defined' if __inclusion_configs.has_key?(name)

          __inclusion_configs[name] = ::Matterhorn::Inclusions.build_inclusion(self, name, options)
        end

      end

    end
  end
end

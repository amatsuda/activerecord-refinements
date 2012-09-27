require 'activerecord-refinements/version'
require 'active_record'

module ActiveRecord
  module Refinements
    refine Symbol do
      def ==(val)
        {self => val}
      end

      def !=(val)
        ["#{self} <> ?", val]
      end

      def =~(val)
        ["#{self} like ?", val]
      end

      def >(val)
        ["#{self} > ?", val]
      end

      def >=(val)
        ["#{self} >= ?", val]
      end

      def <(val)
        ["#{self} < ?", val]
      end

      def <=(val)
        ["#{self} <= ?", val]
      end
    end
  end

  module QueryMethods
    def where(opts = nil, *rest, &block)
      return self if opts.blank? && block.nil?

      relation = clone
      if block
        relation.where_values += build_where(Module.new { using ActiveRecord::Refinements }.module_eval(&block))
      else
        relation.where_values += build_where(opts, rest)
      end
      relation
    end
  end
end

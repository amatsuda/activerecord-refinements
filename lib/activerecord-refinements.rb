require 'activerecord-refinements/version'
require 'active_record'

module ActiveRecord
  module Refinements
    module WhereBlockSyntax
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

    class WhereBlockEvaluator
      using ActiveRecord::Refinements::WhereBlockSyntax

      def evaluate(&block)
        instance_eval &block
      end
    end
  end

  module QueryMethods
    def where(opts = nil, *rest, &block)
      return self if opts.blank? && block.nil?

      relation = clone
      if block
        evaluator = ActiveRecord::Refinements::WhereBlockEvaluator.new
        relation.where_values += build_where(evaluator.evaluate(&block))
      else
        relation.where_values += build_where(opts, rest)
      end
      relation
    end
  end
end

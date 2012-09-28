module ActiveRecord
  module Refinements
    module WhereBlockSyntax
      refine Symbol do
        %i[== != =~ > >= < <=].each do |op|
          define_method(op) {|val| [self, op, val] }
        end
      end
    end

    class WhereBlockEvaluator
      using ActiveRecord::Refinements::WhereBlockSyntax

      def initialize(table)
        @table = table
      end

      def evaluate(&block)
        col, op, val = instance_eval &block
        case op
        when :==
          @table[col].eq val
        when :!=
          @table[col].not_eq val
        when :=~
          @table[col].matches val
        when :>
          @table[col].gt val
        when :>=
          @table[col].gteq val
        when :<
          @table[col].lt val
        when :<=
          @table[col].lteq val
        else
          raise "unexpected op: #{op}"
        end
      end
    end

    module QueryMethods
      def where(opts = nil, *rest, &block)
        if block
          evaluator = ActiveRecord::Refinements::WhereBlockEvaluator.new(table)
          clone.tap do |relation|
            relation.where_values += build_where(evaluator.evaluate(&block))
          end
        else
          super
        end
      end
    end
  end
end

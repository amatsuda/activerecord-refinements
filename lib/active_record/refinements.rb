module ActiveRecord
  module Refinements
    module WhereBlockSyntax
      refine Symbol do
        %i[== != =~ > >= < <=].each do |op|
          define_method(op) {|val| [self, op, val] }
        end
      end
    end

    module QueryMethods
      def where(opts = nil, *rest, &block)
        if block
          col, op, val = Module.new { using ActiveRecord::Refinements::WhereBlockSyntax }.module_eval &block
          arel_node = case op
          when :==
            table[col].eq val
          when :!=
            table[col].not_eq val
          when :=~
            table[col].matches val
          when :>
            table[col].gt val
          when :>=
            table[col].gteq val
          when :<
            table[col].lt val
          when :<=
            table[col].lteq val
          else
            raise "unexpected op: #{op}"
          end

          clone.tap do |relation|
            relation.where_values += build_where(arel_node)
          end
        else
          super
        end
      end
    end
  end
end

require 'activerecord-refinements/version'
require 'active_record'
require 'active_record/refinements'

module ActiveRecord
  module QueryMethods
    prepend ActiveRecord::Refinements::QueryMethods
  end
end

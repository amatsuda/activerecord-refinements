require 'spec_helper'

describe 'Symbol enhancements' do
  describe '#==' do
    subject { User.where { :name == 'matz' }.to_sql }
    it { should =~ /WHERE "users"."name" = 'matz'/ }
  end

  describe '#=~' do
    subject { User.where { :name != 'nobu' }.to_sql }
    it { should =~ /WHERE \("users"."name" != 'nobu'\)/ }
  end

  describe '#>' do
    subject { User.where { :age > 3 }.to_sql }
    it { should =~ /WHERE \("users"."age" > 3\)/ }
  end

  describe '#>=' do
    subject { User.where { :age >= 18 }.to_sql }
    it { should =~ /WHERE \("users"."age" >= 18\)/ }
  end

  describe '#<' do
    subject { User.where { :age < 60 }.to_sql }
    it { should =~ /WHERE \("users"."age" < 60\)/ }
  end

  describe '#<=' do
    subject { User.where { :age <= 35 }.to_sql }
    it { should =~ /WHERE \("users"."age" <= 35\)/ }
  end

  describe '#=~' do
    subject { User.where { :name =~ 'tender%' }.to_sql }
    it { should =~ /WHERE \("users"."name" LIKE 'tender%'\)/ }
  end

  context 'outside of where block' do
    specify {
      expect { :omg > 1 }.to raise_error ArgumentError
    }
  end
end

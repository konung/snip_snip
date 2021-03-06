# frozen_string_literal: true

require 'test_helper'

module SnipSnip
  class FilterTest < ActiveSupport::TestCase
    Post = Class.new
    Comment = Class.new

    class FilterDouble
      def filtered?(_record)
        true
      end
    end

    setup do
      Filter.instance_variable_set(:@instance, nil)
    end

    test '#initialize' do
      assert_equal [ActiveRecord::InternalMetadata], Filter.new.filtered
    end

    test '#filtered?' do
      filter = Filter.new([Post])

      assert filter.filtered?(Post.new)
      refute filter.filtered?(Comment.new)
    end

    test '::filtered?' do
      record = Post.new

      Filter.stub(:new, FilterDouble.new) do
        assert Filter.filtered?(record)
      end
    end
  end
end

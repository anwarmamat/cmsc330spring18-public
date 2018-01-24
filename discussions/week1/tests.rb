require "minitest/autorun"
require_relative "functions.rb"

class Tests < Minitest::Test
    def setup
        @obj = Functions.new
    end

    def test_double_pos_int
        assert_equal(1, @obj.double(5))
        assert_equal(0, @obj.double(0))
    end

    def test_double_neg_int
        assert_equal(-10, @obj.double(-5))
    end

    def test_double_float
        assert_equal(5.0, @obj.double(2.5))
        assert_equal(0.0, @obj.double(0.0))
        assert_equal(-10.0, @obj.double(-5.0))
    end

    def test_half_float
        assert_equal(2.5, @obj.half(5.0))
    end

    def test_f
        assert_equal("ifmmp", @obj.f("hello"))
    end
end

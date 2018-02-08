require "minitest/autorun"
require_relative "disc2.rb"

class PublicTests < Minitest::Test
  def test_evens
    assert_equal([], evens([]))
    assert_equal([2, 4], evens([1, 2, 3, 4]))
  end

  def test_replace_all
    assert_equal([], replace_all([], 1, 2))
    assert_equal([0, 0, 0, 0], replace_all([0, 0, 0, 0], 1, 2))
    assert_equal([0, 2, 2, 2], replace_all([0, 1, 2, 1], 1, 2))
  end

  def test_mult_vals
    assert_equal([], mult_vals({}))
    assert_equal([2, 12, 30, 56], mult_vals({1 => 2, 3 => 4, 5 => 6, 7 => 8}).sort)
  end

  def test_counter_to_array
    assert_equal([], counter_to_array({}))
    assert_equal([1, 2, 2, 3, 4, 4], counter_to_array({1 => 1, 2 => 2, 3 => 1, 4 => 2}).sort)
  end

  def test_map2
    assert_equal([], map2([], []) { |e1, e2| 0 })
    assert_equal([3, 5, 7, 9], map2([1, 2, 3, 4], [2, 3, 4, 5]) { |e1, e2| e1 + e2 })
    assert_equal([0, 0, 0, 0], map2([1, 2, 3, 4], [2, 3, 4, 5]) { |e1, e2| 0 })
  end

  def test_partition
    assert_equal([[], []], partition([]) { |e| true })
    assert_equal([[1, 2, 3, 4], []], partition([1, 2, 3, 4]) { |e| true })
    assert_equal([[1, 3], [2, 4]], partition([1, 2, 3, 4]) { |e| e.odd? })
  end

  def test_extract_student_data
    assert_equal({ :name => "Anwar Mamat", :id => "000000000" }, extract_student_data("name: Anwar Mamat, id: 000000000"))
    
    assert_equal(:error, extract_student_data("name: AnwarMamat, id: 000000000"))
    assert_equal(:error, extract_student_data("name: anwar mamat, id: 000000000"))
    assert_equal(:error, extract_student_data("name: anwar0 mamat, id: 000000000"))

    assert_equal(:error, extract_student_data("name: Anwar Mamat, id: 0000000000"))
    assert_equal(:error, extract_student_data("name: Anwar Mamat, id: 00000000"))
    assert_equal(:error, extract_student_data("name: Anwar Mamat, id: 00000000a"))

    assert_equal(:error, extract_student_data("name: Anwar Mamat,id: 000000000"))
    assert_equal(:error, extract_student_data("name: Anwar Mamat id: 000000000"))
    assert_equal(:error, extract_student_data("Name: Anwar Mamat, ID: 000000000"))
  end

  def test_scan_names
    assert_equal([], scan_names(""))
    assert_equal(["Anwar", "Mike", "Niki", "Tom"], scan_names("AnwarMikeNikiTom"))
    assert_equal(["Anwar", "Mike"], scan_names("AnwarMike niki tom"))
    assert_equal(["Anwar", "Mike", "Ki", "M"], scan_names(" Anwar$Mike niKi toM"))
  end
end

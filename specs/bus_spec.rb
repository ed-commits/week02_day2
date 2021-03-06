require("minitest/autorun")
require("minitest/reporters")
require_relative("../bus")
require_relative("../person")
require_relative("../bus_stop")
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestBus < MiniTest::Test
  def setup()
    @bus1 = Bus.new(22, "Ocean Terminal")
    @person1 = Person.new("Bob", 30)
    @person2 = Person.new("Alice", 31)
    @person3 = Person.new("Carl", 33)
    @person4 = Person.new("Max", 39)
    @stop1 = BusStop.new("Stop 45")
    @stop1.add_person(@person3)
    @stop1.add_person(@person4)
  end

  def test_create_bus()
    assert_equal(22, @bus1.route_number)
    assert_equal("Ocean Terminal", @bus1.distination)
  end

  def test_drive()
    assert_equal("Brum brum", @bus1.drive)
  end

  def test_passengers_starts_empty()
    assert_equal([], @bus1.passengers)
  end

  def test_pick_up()
    @bus1.pick_up(@person1)
    assert_equal(1, @bus1.passengers.length)
  end

  def test_count_passengers()
    result = @bus1.count_passengers()
    assert_equal(0, result)
  end

  def test_drop_of_passengers()
    @bus1.pick_up(@person1)
    assert_equal(1, @bus1.passengers.length)
    @bus1.drop_of_passengers(@person1)
    assert_equal(0, @bus1.passengers.length)
  end

  def test_empty()
    @bus1.pick_up(@person1)
    @bus1.pick_up(@person2)
    @bus1.empty
    assert_equal(0, @bus1.passengers.length)
  end

  def test_pickup_from_stop
    assert_equal(2, @stop1.count_passengers)
    @bus1.pick_up_from_stop(@stop1)
    assert_equal(2, @bus1.passengers.length)
    assert_equal(0, @stop1.count_passengers)
  end
end

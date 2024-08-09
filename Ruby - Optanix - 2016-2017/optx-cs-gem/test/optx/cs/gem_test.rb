require 'test_helper'
require Opts::Cs::gem

class Optx::Cs::GemTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Optx::Cs::Gem::VERSION
  end

  def test_initilization
    include Optx::Cs
    Optx::Initialize
    assert_equal '', $BASE_URL
    assert_equal '', $SAMPSON_DB
    assert_equal '', $SAMPSON_DB_SERVER
    assert_equal '', $SAMPSON_USER 
  end
  
  def test_set_db_connection_params
  end
  
  def test_get_connection
  end
  
  def test_device_exists
  end
  
  def test_map_instance_to_managed_device
  end
  
  def test_setCSConfigValue
  end
  
  def test_getCSConfigValue
  end
  
  def test_setStatusTypeVariables
  end
  
  def test_setStatusLevelInfoVariables
  end
  
  def test_get_creds_from_db
  end
  
  def test_store_creds
  end
  
  def test_evaluate_alarm
  end
  
  def test_defined_alarm
  end
  
  def test_it_does_something_useful
    assert false
  end
end

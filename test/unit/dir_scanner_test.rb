require 'test_helper'

class DirScannerTest < ActiveSupport::TestCase
  test "does scan" do
    DirScanner.doit(".")
  end
  
  test "does scan manually" do
    Rails::logger.debug 'hello'
    Dir.glob('./*') do |f|
      Rails::logger.debug f
    end
  end
end

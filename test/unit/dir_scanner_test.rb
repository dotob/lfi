require 'test_helper'

class DirScannerTest < ActiveSupport::TestCase
  test "does scan" do
    DirScanner.doit(".")
  end
end

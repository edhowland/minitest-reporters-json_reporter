# load_path.rb - extends $LOAD_PATH with minitest-reporters-json_reporter paths
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/reporters/json_reporter'

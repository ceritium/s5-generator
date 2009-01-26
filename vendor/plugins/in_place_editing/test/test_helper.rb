$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'test/unit'
require 'rubygems'

require 'action_controller'
require 'action_controller/assertions'

require 'action_view/helpers/sanitize_helper'

require 'in_place_editing'
require 'in_place_macros_helper'

require 'active_record'

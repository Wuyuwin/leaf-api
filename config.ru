# frozen_string_literal: true

require_relative 'require_app'
require_app

run Leaf::App.freeze.app

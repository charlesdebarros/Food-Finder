#!/usr/bin/env ruby

# frozen_string_literal: true

#### Food Finder ####
#
# Launch this file from the command line to get started.
#

# Set the application root for easy reference.

APP_ROOT = File.dirname(__FILE__)

require_relative('lib/guide')

guide = Guide.new('restaurants.txt')
guide.launch!

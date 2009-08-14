require 'rubygems'
require 'httparty'
require 'activesupport'
gem 'mloughran-api_cache'
require 'api_cache'
require 'pp'

$:.unshift File.join(File.dirname(__FILE__),'..','lib')
require 'a2ws/signature'
require 'a2ws/base'
require 'a2ws/methodize'
require 'a2ws/item'
require 'a2ws/image'
require 'a2ws/item_search'
require 'a2ws/image_search'
APICache.start

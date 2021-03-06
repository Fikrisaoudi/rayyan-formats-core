#!/usr/bin/env ruby

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rayyan-formats-core'
require 'log4r'

logger = Log4r::Logger.new('RayyanFormats')
logger.outputters = Log4r::Outputter.stdout
RayyanFormats::Base.logger = logger

# printing default config
puts RayyanFormats::Base.max_file_size
puts RayyanFormats::Base.plugins

# changing config
RayyanFormats::Base.max_file_size = 10_000_000
RayyanFormats::Base.plugins = [RayyanFormats::Plugins::CSV]
puts RayyanFormats::Base.max_file_size
puts RayyanFormats::Base.plugins

puts RayyanFormats::Plugins::PlainText.extension
puts RayyanFormats::Plugins::PlainText.title
puts RayyanFormats::Base.send(:match_plugin, 'txt')
puts RayyanFormats::Base.send(:match_plugin, 'csv')
begin
  puts RayyanFormats::Base.send(:match_plugin, 'ris')
  puts RayyanFormats::Base.send(:match_plugin, 'foo')
rescue => e
  puts "Exception: #{e.message}"
end
puts RayyanFormats::Base.extensions_str

t1 = RayyanFormats::Target.new
t1.a = 1
t1.b = %w(10 20 30)
puts "t1.a = #{t1.a}"
puts "t1.b = #{t1.b}"
puts "t1.c = #{t1.c}"

s1 = RayyanFormats::Source.new("../rayyan/nonrails/citation_examples/example.csv")
RayyanFormats::Base.import(s1) { |target, total, is_new|
  # post processing for target
  puts "Found target: #{target}. Total: #{total}. is_new: #{is_new}"
}

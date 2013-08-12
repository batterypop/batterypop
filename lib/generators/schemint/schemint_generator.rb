class SchemintGenerator < Rails::Generators::NamedBase
	require 'rubygems'
	require 'active_support/core_ext'
	schema = File.read('db/schema.rb')
	schema.scan(/create_table "(\w+)",.*?\n(.*?)\n  end/m).each do |name, ddl|
	  puts "rails generate scaffold #{name.classify} " +
	    ddl.scan(/t\.(\w+)\s+"(\w+)"/).
	    reject {|type,name| %w(created_at updated_at).include? name}.
	    map {|type,name| "#{name}:#{type}"}.join(' ')
	end
  source_root File.expand_path('../templates', __FILE__)
end

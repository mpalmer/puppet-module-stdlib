module Puppet::Parser::Functions
	newfunction(:is_scalar, :type => :rvalue, :doc => "Returns true iff the variable passed to this function is a string, number or boolean") do |args|
		args.length == 1 or raise Puppet::ParseError.new("is_scalar: expecting 1 argument, got #{args.length}")

		item = args[0]
		[ String, Numeric, TrueClass, FalseClass ].any? { |t| item.is_a? t }
	end
end

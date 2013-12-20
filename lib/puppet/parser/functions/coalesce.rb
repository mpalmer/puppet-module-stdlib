module Puppet::Parser::Functions
	newfunction(:coalesce, :type => :rvalue, :doc => "Given an array or a list of arguments, returns the first item that isn't nil, empty or undef.") do |args|
		a = if args.length == 1 and args[0].is_a?(Array)
			args[0]
		elsif args.length >= 2
			args
		else
			raise Puppet::ParseError.new("coalesce: expecting Array or at least 2 arguments, got #{args.length}")
		end

		result = a.find do |e|
			! e.nil? and e != :undef and e != ""
		end
		result = :undef if result.nil?
		result
	end
end

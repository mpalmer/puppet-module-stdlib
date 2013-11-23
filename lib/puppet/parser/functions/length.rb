# Copyright 2010-2013 Anchor Systems Pty Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License.  You may obtain a
# copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations
# under the License.
#
module Puppet::Parser::Functions
	newfunction(:length, :type => :rvalue, :doc => "Return the size of an array, the number of entries in a hash or the string length of scalar") do |args|
		args.length == 1 or raise Puppet::ParseError.new("length: expecting 1 argument, got #{args.length}")
		x = args[0]

		case x
		when Hash, Array
			x.length.to_s
		else
			is_scalar = Puppet::Parser::Functions.function(:is_scalar) or raise Puppet::Error.new("length: is_scalar could not be loaded")
			send(is_scalar, [x]) or raise Puppet::ParseError.new("length: invalid argument: #{x} (expecting scalar or Array or Hash, got #{x.class})")
			x.to_s.length.to_s
		end
	end
end

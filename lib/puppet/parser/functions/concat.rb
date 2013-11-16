# Copyright 2010,2013 Anchor Systems Pty Ltd
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
	newfunction(:concat, :type => :rvalue, :doc => "Concatenates a list of strings or arrays.") do |args|
		args.length >= 1 or raise Puppet::ParseError.new("concat: expecting at least 1 argument, got #{args.length}")

		initial = args.shift
		if initial.is_a? Array
			args.inject(initial) do |a, v|
				v.is_a? Array or raise Puppet::ParseError.new("concat: invalid argument: #{v} (expecting Array, got #{v.class})")
				a + v
			end
		else
			is_scalar = Puppet::Parser::Functions.function(:is_scalar) or raise Puppet::Error.new("concat: is_scalar could not be loaded")
			send(is_scalar, [initial]) or raise Puppet::ParseError.new("concat: invalid first argument: #{initial} (expecting scalar or Array, got #{initial.class})")
			initial = initial.to_s
			args.inject(initial) do |s, v|
				send(is_scalar, [v]) or raise Puppet::ParseError.new("concat: invalid argument: #{v} (expecting scalar, got #{v.class})")
				s + v.to_s
			end
		end
	end
end

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
	newfunction(:reject, :type => :rvalue, :doc => "Given an array and a regexp, returns the elements of the array that do not match.") do |args|
		args.length == 2 or raise Puppet::ParseError.new("reject: expecting 2 arguments, got #{args.length}")
		(a, r) = args

		a.is_a? Array or raise Puppet::ParseError.new("reject: invalid first argument: #{a} (expecting Array, got #{a.class})")
		is_scalar = Puppet::Parser::Functions.function(:is_scalar) or raise Puppet::Error.new("reject: is_scalar could not be loaded")
		send(is_scalar, [r]) or raise Puppet::ParseError.new("reject: invalid second argument: #{r} (expecting scalar, got #{r.class})")

		regexp = Regexp.compile(r.to_s)
		a.reject do |e|
			send(is_scalar, [e]) or raise Puppet::ParseError.new("reject: invalid array element: #{e} (expecting scalar, got #{e.class})")
			e.to_s =~ regexp
		end
	end
end

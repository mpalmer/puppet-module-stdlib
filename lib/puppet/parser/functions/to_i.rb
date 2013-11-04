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
	newfunction(:to_i, :type => :rvalue, :doc => "Converts any scalar to an integer.") do |args|
		args.length == 1 or raise Puppet::ParseError.new("to_i: expecting 1 argument, got #{args.length}")
		s = args[0]

		# Do *NOT* use Puppet::Parser::Scope.number? here... we want to be able to integerize version numbers

		is_scalar = Puppet::Parser::Functions.function(:is_scalar) or raise Puppet::Error.new("to_i: is_scalar could not be loaded")
		send(is_scalar, [s]) or raise Puppet::ParseError.new("to_i: invalid argument: #{s} (expecting scalar, got #{s.class})")

		s.to_i.to_s
	end
end

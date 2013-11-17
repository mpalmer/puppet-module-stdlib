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
	newfunction(:maybe_split, :type => :rvalue, :doc => "Like split(), but returns the first argument if it is already an array.") do |args|
		args.length == 2 or raise Puppet::ParseError.new("maybe_split: expecting 2 arguments, got #{args.length}")
		(s, r) = args

		return [] if s.nil? or s == :undef or s == ""
		return s  if s.is_a? Array

		is_scalar = Puppet::Parser::Functions.function(:is_scalar) or raise Puppet::Error.new("maybe_split: is_scalar could not be loaded")
		send(is_scalar, [s]) or raise Puppet::ParseError.new("maybe_split: invalid first argument: #{s} (expecting scalar or Array, got #{s.class})")
		send(is_scalar, [r]) or raise Puppet::ParseError.new("maybe_split: invalid second argument: #{r} (expecting scalar, got #{r.class})")

		s.to_s.split(Regexp.compile(r.to_s))
	end
end

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
	newfunction(:compact, :type => :rvalue, :doc => "Interpolates any array arguments, and returns all values that are not nil, empty or undefined.") do |args|
		result = []
		args.each do |a|
			a = [ a ] unless a.is_a? Array
			a.each do |e|
				if e != "" and e != :undef and not e.nil?
					result << e
				end
			end
		end
		result
	end
end

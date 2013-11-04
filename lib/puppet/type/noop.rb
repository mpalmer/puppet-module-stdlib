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
require 'puppet'
require 'puppet/type'

Puppet::Type.newtype(:noop) do
	@doc = <<-EOF
		Does nothing, successfully. 
	EOF

	newparam :name do
		desc 'The name of the resource; not significant.'
		isnamevar
	end

	# Participate in susbcribe/notify relationships
	def refresh
	end
end

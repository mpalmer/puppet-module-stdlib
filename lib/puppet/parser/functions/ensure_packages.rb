# Copyright 2011 Puppet Labs Inc
# Copyright 2013 Matt Palmer <matt@hezmatt.org>
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
require 'puppet/parser/functions'

module Puppet::Parser::Functions
  newfunction(:ensure_packages, :type => :statement, :doc => <<-EOS
Takes a list of packages and only installs them if they don't already exist.

You can pass the package names as either an array, or a set of separate
arguments, or any mix of the two.  All package names must be strings.

If the final argument passed is a hash, it will be used as a set of parameters
to pass to all of the packages created.  Otherwise, the default parameters used
are `{ ensure => present }`.
    EOS
  ) do |arguments|
    if arguments[-1].is_a? Hash
      opts = arguments.pop
    else
    	opts = { 'ensure' => 'present' }
    end
    
    pkglist = arguments.flatten

    Puppet::Parser::Functions.function(:ensure_resource)
    pkglist.each do |package_name|
      unless package_name.is_a? String
        raise ArgumentError,
              "ensure_packages(): Package name must be a string (you gave me #{package_name.inspect})"
      end

      function_ensure_resource(['package', package_name, opts])
    end
  end
end

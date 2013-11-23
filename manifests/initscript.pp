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
define stdlib::initscript($ensure  = present,
                          $source  = undef,
                          $content = undef) {
	if $name !~ /^[\w.-]+$/ {
		fail("Bad initscript name: ${name}")
	}

	if $ensure != absent {
		if length(compact($source, $content)) != 1 {
			fail("Exactly one of source and content must be specified when ensure is ${ensure}")
		}
	}

	case $::operatingsystem {
		RedHat,CentOS: {
			$initscript = "/etc/rc.d/init.d/${name}"
		}
		Debian: {
			$initscript = "/etc/init.d/${name}"
		}
		default: {
			fail("No initscript support on ${::operatingsystem} ${::operatingsystemrelease}")
		}
	}

	case $ensure {
		present: {
			if $source {
				file { $initscript:
					source  => $source,
					mode    => 0555,
					links   => follow;
				}
			} else {
				file { $initscript:
					content => $content,
					mode    => 0555;
				}
			}

			if $::operatingsystem == Debian {
				exec { "oscore/initscript/update-rc.d:${name}":
					command     => shellquote("/usr/sbin/update-rc.d", $name, "defaults"),
					refreshonly => true,
					subscribe   => File[$initscript];
				}
			}
		}
		absent: {
			file { $initscript:
				ensure => absent;
			}

			if $::operatingsystem == Debian {
				exec { "oscore/initscript/update-rc.d:${name}":
					command     => shellquote("/usr/sbin/update-rc.d", "-f", $name, "remove"),
					refreshonly => true,
					subscribe   => File[$initscript];
				}
			}
		}
		default: {
			fail("Unknown value for ensure: ${ensure}")
		}
	}
}

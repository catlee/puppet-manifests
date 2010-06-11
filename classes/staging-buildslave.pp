# staging-buildslave.pp

### These includes all come from files of the same name
### in the /manifests/packages/ tree

class staging-buildslave {
    case $operatingsystem {
        CentOS: {
            include debuginfopackages
            include devtools
            include nagios
            include scratchbox
            include buildbot
            include moz-rpms

            file {
                "/etc/sysconfig/puppet":
                    source => "${local_fileroot}/etc/sysconfig/puppet",
                    owner => "root",
                    group => "root";
            }
        }
        Darwin: {
            include devtools
            include repackaging-tools
            file {
                "/Library/LaunchDaemons/com.reductivelabs.puppet.plist":
                    source => "${local_fileroot}/Library/LaunchDaemons/com.reductivelabs.puppet.plist",
                    owner => "root",
                    group => "wheel";
            }
        }
    }
}

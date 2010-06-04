class puppet-files-build-network {
    case $operatingsystem {
        CentOS: {
            case $hardwaremodel {
                "x86_64": {
                    mount {
                        "puppet-files":
                            name => "/N",
                            ensure => absent
                    }
                }
                default: {
                    mount {
                        "puppet-files":
                            name   => "/N",
                            atboot => true,
                            device => "10.2.71.136:/export/buildlogs/puppet-files",
                            ensure => "mounted",
                            fstype => "nfs",
                            options => "ro",
                            remounts => true;
                    }
                }
            }
        }
    }
}

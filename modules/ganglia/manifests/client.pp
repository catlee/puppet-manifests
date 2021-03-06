class ganglia::client {
    $mode = "mcast"
    # Mozilla configuration
    case $fqdn {
        /^.*\.srv\.releng\.scl3\.mozilla\.com$/: {
            $cluster = "RelEngSCL3Srv"
            $addr = "239.2.11.204"
        }
        /^.*\.build\.scl1\.mozilla\.com$/: {
            $cluster = "RelEngSCL1"
            $addr = "239.2.11.201"
        }
        /^.*\.build\.sjc1\.mozilla\.com$/: {
            $cluster = "RelEngSJC1"
            $addr = "239.2.11.202"
        }
        /^.*\.build\.mtv1\.mozilla\.com$/: {
            $cluster = "RelEngMTV1"
            $addr = "239.2.11.203"
        }
        default: {
            fail("Unsupported fqdn")
        }
    }
    # These come from the mozilla packages repo
    include packages::mozilla-repo
    package {
        ganglia-gmond:
            require => Class["packages::mozilla-repo"],
            ensure => $operatingsystemrelease ? {
                "5.5" => "3.1.7-3",
                "5.8" => "3.1.7-3",
                "6.2" => "3.1.7-3.el6",
            };

        ganglia-gmond-modules-python:
            require => Class["packages::mozilla-repo"],
            ensure => "3.1.7-3";
    }

    service {
        gmond:
            require => File["/etc/ganglia/gmond.conf"],
            enable => true,
            ensure => running;
    }

    file {
        "/etc/ganglia":
            ensure => directory,
            owner => "root",
            group => "root",
            mode => 644;

        "/etc/ganglia/gmond.conf":
            notify => Service[gmond],
            require => Package["ganglia-gmond"],
            content => template("ganglia/gmond.conf"),
            owner => "root",
            group => "root",
            mode => 644;
    }
}

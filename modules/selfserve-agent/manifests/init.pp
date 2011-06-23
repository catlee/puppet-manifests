class selfserve-agent {
    file {
        "/etc/init.d/selfserve-agent":
            source => "puppet:///modules/selfserve-agent/selfserve-agent.initd",
            mode => 755,
            owner => "root",
            group => "root";
        "/etc/nagios/nrpe/nrpe.d/selfserve-agent.cfg":
            content => template("selfserve-agent/selfserve-agent.cfg.erb"),
            notify => Service["nrpe"],
            require => Class["nagios"],
            mode => 644,
            owner => "root",
            group => "root";
    }
    service {
        "selfserve-agent":
            require => File["/etc/init.d/selfserve-agent"],
            enable => true;
    }
    exec {
        "virtualenv":
            require => Package["python26-virtualenv"],
            creates => "/builds/buildbot/selfserve-agent/lib",
            command => "/usr/bin/virtualenv-2.6 /builds/buildbot/selfserve-agent",
            user => "cltbld";
        "clone-buildapi":
            require => [
                        Package["mercurial"],
                        Exec["virtualenv"],
                       ],
            creates => "/builds/buildbot/selfserve-agent/buildapi",
            command => "/usr/bin/hg clone http://hg.mozilla.org/build/buildapi /builds/buildbot/selfserve-agent/buildapi",
            user => "cltbld";
    }
}

# NB that selfserve-agent.ini still needs to be created manually since we
# don't have a way of managing all the branch definitions
class selfserve-agent {
    $plugins_dir = $nagios::service::plugins_dir
    $nagios_etcdir = $nagios::service::etcdir
    $selfserve_dir = "/builds/buildbot/selfserve-agent"
    file {
        "/etc/init.d/selfserve-agent":
            source => "puppet:///modules/selfserve-agent/selfserve-agent.initd",
            mode => 755,
            owner => "root",
            group => "root";
        "$nagios_etcdir/nrpe.d/selfserve-agent.cfg":
            content => template("selfserve-agent/selfserve-agent.cfg.erb"),
            notify => Service["nrpe"],
            require => Class["nagios"],
            mode => 644,
            owner => "root",
            group => "root";
        "$selfserve_dir/run_agent.sh":
            require => Exec["selfserve-virtualenv"],
            content => template("selfserve-agent/run_agent.sh.erb"),
            mode => 755,
            owner => "cltbld",
            group => "cltbld";
    }
    service {
        "selfserve-agent":
            require => File["/etc/init.d/selfserve-agent"],
            ensure => running,
            enable => true;
    }
    exec {
        "selfserve-virtualenv":
            require => Package["python26-virtualenv"],
            creates => "$selfserve_dir/lib",
            command => "/usr/bin/virtualenv-2.6 $selfserve_dir",
            user => "cltbld";
        "clone-buildapi":
            require => [
                        Package["mercurial"],
                        Exec["virtualenv"],
                       ],
            creates => "$selfserve_dir/buildapi",
            command => "/usr/bin/hg clone http://hg.mozilla.org/build/buildapi $selfserve_dir/buildapi",
            user => "cltbld";
        "install-buildapi":
            require => Exec["clone-buildapi"],
            creates => "$selfserve_dir/buildapi/lib/python2.6/site-packages/buildapi.egg-link",
            command => "$selfserve_dir/bin/python $selfserve_dir/buildapi/setup.py develop",
            cwd => $selfserve_dir,
            user => "cltbld";
    }
}

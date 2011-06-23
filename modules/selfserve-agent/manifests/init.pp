# NB that selfserve-agent.ini still needs to be created manually since we
# don't have a way of managing all the branch definitions
class selfserve-agent {
    $plugins_dir = $nagios::service::plugins_dir
    $nagios_etcdir = $nagios::service::etcdir
    $selfserve_dir = "/builds/buildbot/selfserve-agent"
    $python_package_dir = "$httproot/python-packages"
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
            require => [
                    File["/etc/init.d/selfserve-agent"],
                    File["$selfserve_dir/run_agent.sh"],
                    Exec["install-buildapi"],
                    Exec["install-buildbot"]
                    ],
            ensure => running,
            enable => true;
    }
    exec {
        "selfserve-virtualenv":
            require => Package["python26-virtualenv"],
            creates => "$selfserve_dir/lib",
            command => "/usr/bin/virtualenv-2.6 $selfserve_dir",
            user => "cltbld";

        # We need buildbot so we can run sendchanges from the selfserve agent
        "clone-buildbot":
            require => [
                        Package["mercurial"],
                        Exec["selfserve-virtualenv"],
                       ],
            creates => "$selfserve_dir/buildbot",
            command => "/usr/bin/hg clone -r production-0.8 http://hg.mozilla.org/build/buildbot $selfserve_dir/buildbot",
            user => "cltbld";
        "install-buildbot":
            require => Exec["clone-buildbot"],
            creates => "$selfserve_dir/bin/buildbot",
            command => "$selfserve_dir/bin/python setup.py install",
            cwd => "$selfserve_dir/buildbot/master",
            environment => [
                "PIP_DOWNLOAD_CACHE=$selfserve_dir/pip_cache",
                "PIP_FLAGS=--no-deps --no-index --find-links=$python_package_dir",
            ],
            user => "cltbld";

        # Clone/install buildapi itself
        "clone-buildapi":
            require => [
                        Package["mercurial"],
                        Exec["selfserve-virtualenv"],
                       ],
            creates => "$selfserve_dir/buildapi",
            command => "/usr/bin/hg clone http://hg.mozilla.org/build/buildapi $selfserve_dir/buildapi",
            user => "cltbld";
        "install-buildapi":
            require => Exec["clone-buildapi"],
            creates => "$selfserve_dir/lib/python2.6/site-packages/buildapi.egg-link",
            command => "$selfserve_dir/bin/python setup.py develop",
            environment => [
                "PIP_DOWNLOAD_CACHE=$selfserve_dir/pip_cache",
                "PIP_FLAGS=--no-deps --no-index --find-links=$python_package_dir",
            ],
            cwd => "$selfserve_dir/buildapi",
            user => "cltbld";
    }
}

# buildmaster::queue class
# sets up queue processors for pulse, commands, etc.

class buildmaster::queue {
    # For queue processors
    $queue_venv = "${master_basedir}/queue"
    python::virtualenv {
        $queue_venv:
            user => "cltbld",
            group => "cltbld",
            python => "/usr/bin/python2.6",
            packages => [
                "simplejson",
                "buildbot==0.8.4-pre-moz1",
                "Twisted==10.1.0",
                "zope.interface==3.6.1",
            ],
    }
    exec {
        # Clone/install tools
        "clone-tools":
            require => [
                        Package["mercurial"],
                        Python::Virtualenv[$queue_venv],
                       ],
            creates => "$queue_venv/tools",
            command => "/usr/bin/hg clone http://hg.mozilla.org/build/tools $queue_venv/tools",
            user => "cltbld";
        "install-tools":
            require => Exec["clone-tools"],
            creates => "$queue_venv/lib/python2.6/site-packages/buildtools.egg-link",
            command => "$queue_venv/bin/python setup.py develop",
            cwd => "$queue_venv/tools",
            user => "cltbld";
    }

    $plugins_dir = $nagios::service::plugins_dir
    $nagios_etcdir = $nagios::service::etcdir
    file {
        "/etc/init.d/command_runner":
            content => template("buildmaster/command_runner.initd.erb"),
            notify => Service["command_runner"],
            mode => 755,
            owner => "root",
            group => "root";
        "${queue_venv}/run_command_runner.sh":
            require => Python::Virtualenv[$queue_venv],
            content => template("buildmaster/run_command_runner.sh.erb"),
            notify => Service["command_runner"],
            mode => 755,
            owner => "root",
            group => "root";
        "$nagios_etcdir/nrpe.d/command_runner.cfg":
            content => template("buildmaster/command_runner.cfg.erb"),
            notify => Service["nrpe"],
            require => Class["nagios"],
            mode => 644,
            owner => "root",
            group => "root";

        "/etc/init.d/pulse_publisher":
            content => template("buildmaster/pulse_publisher.initd.erb"),
            notify => Service["pulse_publisher"],
            mode => 755,
            owner => "root",
            group => "root";
        "${queue_venv}/run_pulse_publisher.sh":
            require => Python::Virtualenv[$queue_venv],
            content => template("buildmaster/run_pulse_publisher.sh.erb"),
            notify => Service["pulse_publisher"],
            mode => 755,
            owner => "root",
            group => "root";
        "${queue_venv}/passwords.py":
            require => Python::Virtualenv[$queue_venv],
            content => template("buildmaster/passwords.py.erb"),
            mode => 600,
            owner => "cltbld",
            group => "cltbld";
        "$nagios_etcdir/nrpe.d/pulse_publisher.cfg":
            content => template("buildmaster/pulse_publisher.cfg.erb"),
            notify => Service["nrpe"],
            require => Class["nagios"],
            mode => 644,
            owner => "root",
            group => "root";
    }
    service {
        "command_runner":
            hasstatus => true,
            require => [
                Python::Virtualenv[$queue_venv],
                File["/etc/init.d/command_runner"],
                File["${queue_venv}/run_command_runner.sh"],
                ],
            enable => true,
            ensure => running;
        "pulse_publisher":
            hasstatus => true,
            require => [
                Python::Virtualenv[$queue_venv],
                File["/etc/init.d/pulse_publisher"],
                File["${queue_venv}/run_pulse_publisher.sh"],
                ],
            enable => true,
            ensure => running;
    }

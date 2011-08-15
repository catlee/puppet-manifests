# buildmaster class
# include this in your node to have all the base requirements for running a
# buildbot master installed
# To setup a particular instance of a buildbot master, see
# buildmaster::buildbot_master
#
# buildmaster requires that $num_masters be set on the node prior to including this class
#
# TODO: move $libdir stuff into template?
# TODO: you still have to set up ssh keys!
# TODO: determine num_masters from json (bug 647374)
class buildmaster {
    include releng::master
    include secrets
    $master_user = "cltbld"
    $master_group = "cltbld"
    $master_user_uid = 500
    $master_group_gid = 500
    $master_basedir = "/builds/buildbot"
    package {
        "python26":
            ensure => latest;
        "python26-virtualenv":
            ensure => latest;
        "mysql-devel":
            ensure => latest;
        "git":
            ensure => latest;
        "gcc":
            ensure => latest;
    }
    service {
        "buildbot":
            require => File["/etc/init.d/buildbot"],
            enable => true;
    }
    user {
        $master_user:
            require => Group[$master_group],
            ensure => "present",
            name => $master_user,
            uid => $master_user_uid,
            gid => $master_group_gid,
            comment => "Client Builder",
            managehome => true,
            home => "/home/$master_user",
            shell => "/bin/bash",
            password => $secrets::cltbld_password;
    }
    group {
        $master_group:
            ensure => "present",
            name => $master_group,
            gid => $master_group_gid;
    }
    file {
        "/builds":
            ensure => directory,
            owner => $master_user,
            group => $master_group;
        $master_basedir:
            ensure => directory,
            owner => $master_user,
            group => $master_group;
        "/etc/default/buildbot.d/":
            owner => "root",
            group => "root",
            mode => 755,
            ensure => directory;
        "/etc/init.d/buildbot":
            source => "puppet:///modules/buildmaster/buildbot.initd",
            mode => 755,
            owner => "root",
            group => "root";
        "/root/.my.cnf":
            content => template("buildmaster/my.cnf.erb"),
            mode => 600,
            owner => "root",
            group => "root";
    }
    exec {
        "clone-configs":
            creates => "$master_basedir/buildbot-configs",
            command => "/usr/bin/hg clone -r production http://hg.mozilla.org/build/buildbot-configs",
            user => $master_user,
            cwd => $master_basedir;
    }

    # For queue processors
    $queue_venv = "${master_basedir}/queue"
    python::virtualenv {
        $queue_venv:
            user => "cltbld",
            group => "cltbld",
            python => "/usr/bin/python2.6",
            packages => ["simplejson"];
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

    }
    service {
        "command_runner":
            hashstatus => true,
            require => [
                Python::Virtualenv[$queue_venv],
                File["/etc/init.d/command_runner"],
                File["${queue_venv}/run_command_runner.sh"],
                ],
            enable => true,
            ensure => running;
    }
    # TODO: nagios checks
}

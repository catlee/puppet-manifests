class buildapi {
    include nginx
    include nagios
    package {
        "python26":
            ensure => latest;
        "python26-devel":
            ensure => latest;
        "mysql-devel":
            ensure => latest;
        "mercurial":
            ensure => latest;
        "git":
            ensure => latest;
    }
    file {
        "/tools":
            ensure => directory;
        "/var/www":
            ensure => directory;
        "/etc/init.d/buildapi":
            require => Exec["clone-buildapi"],
            mode => 755,
            source => "puppet:///modules/buildapi/buildapi.initd";
    }
    service {
        "buildapi":
            require => File["/etc/init.d/buildapi"],
            enable => true,
            ensure => running;
    }
    user {
        "buildapi":
            ensure => present;
    }
    python::virtualenv {
        "/home/buildapi":
            require => [Package["python26"], Package["python26-devel"], Package["mysql-devel"]],
            packages => [
            ],
            user => "buildapi",
            python => "/usr/bin/python2.6";
    }
    exec {
        "clone-buildapi":
            require => Python::Virtualenv["/home/buildapi"],
            command => "/usr/bin/hg clone http://hg.mozilla.org/build/buildapi /home/buildapi/src",
            user => "buildapi",
            creates => "/home/buildapi/src";
        "install-buildapi":
            require => Exec["clone-buildapi"],
            user => "buildapi",
            command => "/home/buildapi/bin/python setup.py develop",
            creates => "/home/buildapi/lib/python2.6/site-packages/buildapi",
            cwd => "/home/buildapi/src";
    }
}

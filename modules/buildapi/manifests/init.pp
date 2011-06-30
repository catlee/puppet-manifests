class buildapi {
    package {
        "python26":
            ensure => latest;
        "python26-devel":
            ensure => latest;
        "mysql-devel":
            ensure => latest;
        "nginx":
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
        "/var/www/wsgi":
            ensure => directory;
    }
    user {
        "buildapi":
            home => "/var/www/wsgi/buildapi",
            ensure => present;
    }
    python::virtualenv {
        "/var/www/wsgi/buildapi":
            require => [Package["python26"], Package["python26-devel"], Package["mysql-devel"]],
            packages => [
                "pylons",
                "mysql-python",
            ],
            python => "/usr/bin/python2.6";
    }
    exec {
        "clone-buildapi":
            require => Python::Virtualenv["/var/www/wsgi/buildapi"],
            command => "/usr/bin/hg clone http://hg.mozilla.org/build/buildapi /var/www/wsgi/buildapi/src",
            creates => "/var/www/wsgi/buildapi/src";
        "install-buildapi":
            require => Exec["clone-buildapi"],
            command => "/var/www/wsgi/buildapi/bin/python setup.py install",
            creates => "/var/www/wsgi/buildapi/lib/python2.6/site-packages/buildapi",
            cwd => "/var/www/wsgi/buildapi/src";
    }
}

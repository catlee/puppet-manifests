class buildapi {
    package {
        "python2.6":
            ensure => latest;
        "mysql-devel":
            ensure => latest;
    }
    python::virtualenv {
        "/var/www/wsgi/buildapi":
            require => [Package["python2.6"], Package["python2.6-devel"], Package["mysql-devel"]],
            packages => [
                "pylons",
                "mysql-python",
            ],
            python => "/usr/bin/python2.6";
    }
}

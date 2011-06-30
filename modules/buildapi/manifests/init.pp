class buildapi {
    package {
        "python2.6":
            ensure => latest;
    }
    python::virtualenv {
        "/var/www/wsgi/buildapi":
            require => Package["python2.6"],
            python => "/usr/bin/python2.6";
    }
}

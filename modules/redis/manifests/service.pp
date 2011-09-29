class redis::service {
    file {
        "/etc/redis/default.conf":
            require => Class["redis::install"],
            source => "puppet:///modules/redis/default.conf";
    }
    service {
        "redis":
            require => File["/etc/redis.conf"],
            subscribe => File["/etc/redis.conf"],
            enable => true,
            hasstatus => true,
            ensure => running;
    }
}


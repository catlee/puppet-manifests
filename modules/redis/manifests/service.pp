class redis::service {
    file {
        "/etc/redis.conf":
            require => Class["redis::install"],
            source => "puppet:///modules/redis/redis.conf";
    }
    service {
        "redis":
            require => File["/etc/redis.conf"],
            subscribe => File["/etc/redis.conf"],
            enable => true,
            ensure => running;
    }
}


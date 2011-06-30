class redis {
    package {
        "redis":
            ensure => latest;
    }
    file {
        "/etc/redis.conf":
            requires => Package["redis"],
            source => "puppet:///modules/redis/redis.conf";
    }
    service {
        "redis":
            requires => File["/etc/redis.conf"],
            subscribe => File["/etc/redis.conf"],
            enable => true,
            ensure => running;
    }
}

class rabbitmq {
    package {
        "rabbitmq-server":
            ensure => latest;
    }
    service {
        "rabbitmq-server":
            require => Package["rabbitmq-server"],
            enabled => true,
            ensure => running;
    }
}

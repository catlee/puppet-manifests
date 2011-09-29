class rabbitmq {
    package {
        "rabbitmq-server":
            ensure => latest;
    }
    service {
        "rabbitmq-server":
            require => Package["rabbitmq-server"],
            enable => true,
            hasstatus => true,
            ensure => running;
    }
    rabbitmq::user {
        "guest":
            ensure => absent;
    }
    rabbitmq::vhost {
        "/": ;
    }
}

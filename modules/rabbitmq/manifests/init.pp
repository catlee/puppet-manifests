class rabbitmq {
    package {
        "rabbitmq-server":
            ensure => latest;
    }
}

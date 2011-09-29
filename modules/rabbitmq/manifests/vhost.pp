# rabbitmq::vhost
#
# Usage:
# rabbitmq::vhost {
#   '/path': ;
# }
define rabbitmq::vhost {
    exec {
        "rabbit_vhost_${title}":
            require => Service["rabbitmq-server"],
            command => "/usr/sbin/rabbitmqctl add_vhost ${title}",
            unless => "/usr/sbin/rabbitmqctl list_vhosts | grep -q '^${title}'";
    }
}

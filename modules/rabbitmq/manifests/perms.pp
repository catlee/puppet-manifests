# rabbitmq::perms
#
# Usage:
# rabbitmq::perms {
#   'user':
#       conf => '.*',
#       write => '.*',
#       read => '.*',
#       vhost => '/foo';
# }
define rabbitmq::perms($conf, $write, $read, $vhost='/') {
    $user = $title;
    exec {
        "rabbit_perms_${user}_${vhost}":
            require => [
                Rabbitmq::User[$user],
                Rabbitmq::Vhost[$vhost],
            ],
            command => "/usr/sbin/rabbitmqctl set_permissions -p '${vhost}' '${user}' '${conf}' '${write}' '${read}'";
    }
}
    

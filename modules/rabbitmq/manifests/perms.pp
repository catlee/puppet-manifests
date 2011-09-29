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
define rabbitmq::perms($conf, $write, $read, $vhost='/', $user='') {
    case $user {
        '': { $realuser = $title }
        default: { $realuser = $user }
    }
    exec {
        "rabbit_perms_${realuser}:${vhost}":
            require => [
                Rabbitmq::User[$realuser],
                Rabbitmq::Vhost[$vhost],
            ],
            command => "/usr/sbin/rabbitmqctl set_permissions -p '${vhost}' '${realuser}' '${conf}' '${write}' '${read}'",
            unless => "/usr/sbin/rabbitmqctl list_user_permissions ${realuser} | grep -q -F '${vhost}	${conf}	${write}	${read}'";
    }
}
    

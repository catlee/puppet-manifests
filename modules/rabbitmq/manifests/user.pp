# rabbitmq::user
#
# Usage:
# rabbitmq::user {
#   'foo':
#       password => 'secret';
# }
        
define rabbitmq::user($password) {
    require => Class["rabbitmq"]

    exec {
        "rabbit_user_${name}":
            command => "/usr/sbin/rabbitmqctl add_user $name $password",
            unless => "/usr/sbin/rabbitmqctl list_users | grep -q '${name}'";
    }
}

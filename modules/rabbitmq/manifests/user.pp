# rabbitmq::user
#
# Usage:
# rabbitmq::user {
#   'foo':
#       password => 'secret';
# }
        
define rabbitmq::user($ensure='present', $password='') {
    case $ensure {
        'absent': {
            exec {
                "rabbit_user_${name}":
                    require => Class["rabbitmq"],
                    command => "/usr/sbin/rabbitmqctl delete_user '$name'",
                    unless => "/usr/sbin/rabbitmqctl list_users | grep -v -q '^${name}'";
            }
        }
        'present': {
            exec {
                "rabbit_user_${name}":
                    require => Class["rabbitmq"],
                    command => "/usr/sbin/rabbitmqctl add_user '$name' '$password'",
                    unless => "/usr/sbin/rabbitmqctl list_users | grep -q '^${name}'";
                "rabbit_password_${name}":
                    require => Exec["rabbit_user_${name}"],
                    command => "/usr/sbin/rabbitmqctl change_password '$name' '$password'";
            }
        }
        default: {
            fail("Unsupported value for ensure: $ensure")
        }
    }
}

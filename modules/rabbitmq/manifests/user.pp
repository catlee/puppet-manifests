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
                "rabbit_user_${title}":
                    require => Service["rabbitmq-server"],
                    command => "/usr/sbin/rabbitmqctl delete_user '$title'",
                    unless => "/usr/sbin/rabbitmqctl list_users | grep -v -q '^${title}'";
            }
        }
        'present': {
            exec {
                "rabbit_user_${title}":
                    require => Service["rabbitmq-server"],
                    command => "/usr/sbin/rabbitmqctl add_user '$title' '$password'",
                    unless => "/usr/sbin/rabbitmqctl list_users | grep -q '^${title}'";
                "rabbit_password_${title}":
                    require => Exec["rabbit_user_${title}"],
                    command => "/usr/sbin/rabbitmqctl change_password '$title' '$password'";
            }
        }
        default: {
            fail("Unsupported value for ensure: $ensure")
        }
    }
}

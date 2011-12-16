# service_manager module
#
# can update code that a service is running with
# and restart it if code has changed
#
# Usage:
# service_manager {
#      "buildapi":
#           service => "buildapi",
#           updatecmd => ...
#           minute => # as per cron
#           
            
define service_manager($service, $updatecmd, $minute, $user) {
    file {
        "/usr/local/bin/${name}.cron":
            content => template("service_manager/cronscript.erb"),
            mode => 0755,
            owner => 'root',
            group => 'root';
    }
    cron {
        "$name-service_manager":
            require => File["/usr/local/bin/${name}.cron"],
            command => "/usr/local/bin/${name}.cron",
            user => 'root',
            minute => $minute;
    }
}


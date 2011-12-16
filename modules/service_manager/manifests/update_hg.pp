class service_manager::update_hg {
    $cmd = "/usr/local/bin/update_hg.sh"
    file {
        $cmd:
            source => "puppet://service_manager/update_hg.sh",
            owner => 'root',
            group => 'root',
            mode => 0755;
    }
}

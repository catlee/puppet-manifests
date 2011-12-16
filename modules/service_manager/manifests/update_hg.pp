class service_manager::update_hg {
    $service_manager::update_hg::cmd = "/usr/local/bin/update_hg.sh"
    file {
        $service_manager::update_hg::cmd:
            source => "puppet://service_manager/update_hg.sh",
            owner => 'root',
            group => 'root',
            mode => 0755;
    }
}

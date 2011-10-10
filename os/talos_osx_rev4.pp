# talos_osx_rev4.pp
# This file is divided into a large case statement which
# separates Mac OS X 10.6 and 10.5 followed by a section
# where common configuration is noted

class talos_osx_rev4 {
    include buildslave::install
    include buildslave::startup
    include buildslave::cleanup
    include boot

    case $macosx_productversion_major {
        "10.6": {
            # Mac OS X 10.6 specific configuration
            package {
                "wget-1.10.2.dmg":
                    provider => pkgdmg,
                    ensure => installed,
                    source => "${platform_httproot}/DMGs/wget-1.10.2.dmg";
                "mercurial-1.3.1.dmg":
                    provider => pkgdmg,
                    ensure => installed,
                    source => "${platform_httproot}/DMGs/mercurial-1.3.1.dmg";
                # this is a minimal Xcode installation with the bare minimum needed
                # for our python systems to work.
                "python-sdk-3.2.6.dmg":
                    provider => pkgdmg,
                    ensure => installed,
                    source => "${platform_httproot}/DMGs/python-sdk-3.2.6.dmg",
                    require => File['/Library/Ruby/Gems/1.8/gems/puppet-0.24.8/lib/puppet/provider/package/pkgdmg.rb'],
                    before => Class["buildslave::install"];
                "pyyaml-3.10.dmg": # note that this dmg installs PyYAML for py25 and py26
                    provider => pkgdmg,
                    ensure => installed,
                    source => "${platform_httproot}/DMGs/pyyaml-3.10.dmg";
                "screenresolution-1.4.dmg":
                    provider => pkgdmg,
                    ensure => installed,
                    source => "${platform_httproot}/DMGs/screenresolution-1.4.dmg";
            }

            file {
                "/etc/sudoers":
                    source => "${platform_fileroot}/etc/sudoers",
                    owner => "root",
                    group => "wheel",
                    mode => 440;
                "/Users/cltbld/bin/python":
                    ensure => "/usr/bin/python2.5",
                    owner  => "root",
                    group  => "staff",
                    alias  => "create_python_symlink";
                "/Users/cltbld/bin":
                    ensure => "directory",
                    owner  => "cltbld",
                    group  => "staff",
                    alias  => "create_bin_directory",
                    before => File["create_python_symlink"];
                "/Users/cltbld/.bash_profile":
                    source => "${platform_fileroot}/Users/cltbld/.bash_profile",
                    owner  => "root",
                    group  => "wheel";
                # install_name_tool is required by our python infrastructure
                "/usr/bin/install_name_tool":
                    source => "${platform_fileroot}/usr/bin/install_name_tool",
                    owner => "root",
                    group => "staff",
                    mode => 755,
                    before => Package['python-sdk-3.2.6.dmg'];
                "/usr/local/bin/disable-screensaver.sh":
                    source => "${platform_fileroot}/usr/local/bin/disable-screensaver.sh",
                    owner => "root",
                   group => "staff",
                    mode => 755;
                "/Library/Ruby/Gems/1.8/gems/puppet-0.24.8/lib/puppet/provider/package/pkgdmg.rb":
                    source => "${platform_fileroot}/Library/Ruby/Gems/1.8/gems/puppet-0.24.8/lib/puppet/provider/package/pkgdmg.rb",
                    owner => "root",
                    group => "admin",
                    alias => "pkgdmg.rb";
                "/private/etc/apache2/other/talos.conf":
                    source => "${platform_fileroot}/private/etc/apache2/other/talos.conf",
                    owner => "root",
                    group => "wheel",
                    mode => 644;
                "/Library/LaunchAgents/screenresolution.plist":
                    source => "${platform_fileroot}/Library/LaunchAgents/screenresolution.plist",
                    owner => "root",
                    group => "wheel",
                    require => Package["screenresolution-1.4.dmg"];
                "/etc/ScreenSharing.launchd":
                    ensure => "present";
           }

           exec {
                # See http://docs.info.apple.com/article.html?path=remotedesktop/3.0/en/ardc881.html
                "turn-off-sleep":
                    command => "/usr/sbin/systemsetup -setsleep Never";
                "turn-on-auto-power":
                    command => "/usr/sbin/systemsetup -setrestartpowerfailure on";
                "restart-on-panic":
                    command => "/usr/sbin/systemsetup -setrestartfreeze on";
                "disable-screensaver":
                    command => "/usr/bin/sudo -u cltbld /usr/local/bin/disable-screensaver.sh",
                    require => File["/usr/local/bin/disable-screensaver.sh"];
                "disallow-sleep-button":
                    command => "/usr/sbin/systemsetup -setallowpowerbuttontosleepcomputer off";
                "disable-updater":
                    command => "/usr/sbin/softwareupdate --schedule off";
                "set-time-server":
                    command => "/usr/sbin/systemsetup -setnetworktimeserver ntp1.build.mozilla.org";
                # Using -w will enable the service for future boots, this command does tick the box
                # for remote-login in the Sharing prefpane (survives reboot)
                "turn-on-ssh":
                    command => "/bin/launchctl load -w /System/Library/LaunchDaemons/ssh.plist",
                    onlyif => "/bin/bash -xc '/bin/echo | /usr/bin/nc localhost 22 | /usr/bin/grep SSH-2.0 ; if [ $? -eq 0 ] ; then exit 1 ; else exit 0 ; fi'";
                # apachectl internally loads the org.apache.httpd.plist daemon.  Assuming that it
                # uses the launchctl -w flag to persist state. this command does tick the box in
                # the sharing prefpane (survives reboot)
                "turn-on-httpd":
                    command => "/usr/sbin/apachectl restart",
                    onlyif => "/bin/bash -xc '/usr/bin/curl -I localhost | grep \"HTTP/1.1 200 OK\" ; if [ $? -eq 0 ] ; then exit 1 ; else exit 0 ; fi'";
           }
        }
        "10.5": {
            # Mac OS X 10.5 specific configuration
            install_dmg {
                "mercurial-1.2.1.dmg":
                    creates => "/Library/Python/2.5/site-packages/mercurial/verify.py",
                    alias   => "mercurial";
            }
            #Note that this is in addition to stopping blued
            file {
                "/Library/Preferences/com.apple.Bluetooth.plist":
                    owner => "root",
                    group => "admin",
                    mode => 644,
                    source => "${platform_fileroot}/Library/Preferences/com.apple.Bluetooth.plist";
            # Manage screen resolution
            "/Library/LaunchAgents/cscreen.resize.plist":
                owner => "root",
                group => "wheel",
                mode => 644,
                require => File["/Users/cltbld/cscreen"],
                source => "${platform_fileroot}/Library/LaunchAgents/cscreen.resize.plist";
            "/Users/cltbld/cscreen":
                owner => "cltbld",
                group => "staff",
                mode => 755,
                source => "${platform_fileroot}/Users/cltbld/cscreen";
            }

        }
    }

    # Mac OS X 10.6 and 10.5 common configuration

    file {
        ["/usr/local", "/usr/local/bin", "/usr/local/etc",
         "/usr/local/lib", "/usr/local/libexec", "/usr/local/share",
         "/usr/local/var", "/usr/local/include", "/usr/local/info"]:
            ensure => directory,
            owner => "root",
            group => "wheel",
            mode => 755;
        # Used to have an NFS mount here, not needed anymore.
        "/etc/fstab":
            ensure => absent;
        "/usr/local/bin/hg":
            owner => "root",
            group => "staff",
            mode   => 755,
            source => "${platform_fileroot}/usr/local/bin/hg";
        "/usr/local/bin/check-for-package.sh":
            owner => "root",
            group => "staff",
            mode  => 755,
            source => "${platform_fileroot}/usr/local/bin/check-for-package.sh";
        "/usr/local/bin/run-puppet.sh":
            owner => "root",
            group => "wheel",
            mode  => 755,
            source => "${platform_fileroot}/usr/local/bin/run-puppet.sh";
        "/tools":
            ensure => directory,
            owner => "cltbld",
            group => "staff",
            mode => 755;
        "/Users/cltbld/Library/Preferences/com.apple.DownloadAssessment.plist":
            owner => "cltbld",
            group => "staff",
            source => "${platform_fileroot}/Users/cltbld/Library/Preferences/com.apple.DownloadAssessment.plist";
        "/Users/cltbld/Library/Preferences/com.apple.LaunchServices.plist":
            owner => "cltbld",
            group => "staff",
            source => "${platform_fileroot}/Users/cltbld/Library/Preferences/com.apple.LaunchServices.plist";
        "/Users/cltbld/Library/Preferences/com.apple.dock.plist":
            owner => "cltbld",
            group => "staff",
            mode => 644,
            source => "${platform_fileroot}/Users/cltbld/Library/Preferences/com.apple.dock.plist";
        "${home}/cltbld/.ssh":
            owner => "cltbld",
            group => "staff",
            mode => 700,
            ensure => directory;
        "${home}/cltbld/.ssh/authorized_keys":
            owner => "cltbld",
            group => "staff",
            mode => 644,
            source => "${platform_fileroot}${home}/cltbld/.ssh/authorized_keys";
        "${home}/cltbld/talos-slave":
            ensure => directory,
            owner => "cltbld",
            group => "staff",
            mode => 775;
        "${home}/cltbld/talos-slave/talos-data":
            ensure => directory,
            owner => "cltbld",
            group => "staff",
            mode => 775;
    }

    exec {
        disable-indexing:
            command => "/usr/bin/mdutil -a -i off";
        remove-index:
            command => "/usr/bin/mdutil -a -E";
    }

    service {
        "com.apple.blued":
            ensure => "stopped",
            enable => false;
    }

}

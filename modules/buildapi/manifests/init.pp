class buildapi {
    include nginx
    include nagios
    package {
        "python26":
            ensure => latest;
        "python26-devel":
            ensure => latest;
        "mysql-devel":
            ensure => latest;
        "mercurial":
            ensure => latest;
        "git":
            ensure => latest;
    }
    file {
        "/tools":
            ensure => directory;
        "/var/www":
            ensure => directory;
        "/etc/init.d/buildapi":
            require => Exec["clone-buildapi"],
            mode => 755,
            source => "puppet:///modules/buildapi/buildapi.initd";
    }
    service {
        "buildapi":
            require => File["/etc/init.d/buildapi"],
            enable => true,
            ensure => running;
    }
    user {
        "buildapi":
            ensure => present;
    }
    python::virtualenv {
        "/home/buildapi":
            require => [Package["python26"], Package["python26-devel"], Package["mysql-devel"]],
            packages => [
                "Beaker==1.5.3",
                "BeautifulSoup==3.0.8.1",
                "FormEncode==1.2.2",
                "Mako==0.3.3",
                "MySQL-python==1.2.3c1",
                "Paste==1.7.4",
                "PasteDeploy==1.3.3",
                "PasteScript==1.7.3",
                "Pygments==1.3.1",
                "Pylons==1.0",
                "Routes==1.12.3",
                "SQLAlchemy==0.6.8",
                "Tempita==0.4",
                "WebError==0.10.2",
                "WebHelpers==1.0",
                "WebOb==0.9.8",
                "WebTest==1.2.1",
                "amqplib==0.6.1",
                "anyjson==0.3",
                "carrot==0.10.7",
                "decorator==3.2.0",
                "gviz-api.py==1.7.0",
                "httplib2==0.4.0",
                "processing==0.52",
                "pytz==2010o",
                "redis==2.2.2",
                "simplejson==2.0.9",
                "virtualenv==1.4.9",
                "wsgiref==0.1.2",
                "zope.interface==3.5.1",
            ],
            user => "buildapi",
            python => "/usr/bin/python2.6";
    }
    exec {
        "clone-buildapi":
            require => Python::Virtualenv["/home/buildapi"],
            command => "/usr/bin/hg clone http://hg.mozilla.org/build/buildapi /home/buildapi/src",
            user => "buildapi",
            creates => "/home/buildapi/src";
        "install-buildapi":
            require => Exec["clone-buildapi"],
            user => "buildapi",
            command => "/home/buildapi/bin/python setup.py develop",
            creates => "/home/buildapi/lib/python2.6/site-packages/buildapi",
            cwd => "/home/buildapi/src";
    }
}

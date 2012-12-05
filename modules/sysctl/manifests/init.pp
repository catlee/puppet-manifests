define sysctl($value) {
    exec {
        "sysctl-$name":
            command => "/sbin/sysctl $name=$value",
            onlyif  => "/sbin/sysctl $name | grep -q -v $value";
    }
}

# staging-buildslave.pp

### These includes all come from files of the same name
### in the /manifests/packages/ tree

class staging-buildslave {
    case $operatingsystem {
        CentOS: {
            include packages::debuginfopackages
            include packages::devtools
            include packages::nagios
            include packages::scratchbox
            include packages::moz-rpms
        }
        Darwin: {
            include packages::devtools
            include packages::repackaging-tools
            include packages::cacert
        }
    }
}

# talosslave.pp

class talosslave {
## This assumes that other directories (like os/*) have been imported!

    case $operatingsystem {
        Darwin: { include talos_osx }
    }
}

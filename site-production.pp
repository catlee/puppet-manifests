# site.pp

import "os/*"
import "classes/*"
import "build/*"
import "packages/*"
import "ssh-keys/*"

$puppetServer = "production-puppet.build.mozilla.org"
$fileroot = "puppet://${puppetServer}/"
$httproot = "http://${puppetServer}/"

### Node definitions

node "linux-ref-platform.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "linux-ix-ref.mv.mozilla.com" {
    include base, buildslave, cltbld, build-network, ix
}

node "moz2-linux-slave01.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave02.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave05.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave06.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave07.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave08.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave09.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave10.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave11.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave12.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave13.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave14.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave15.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave16.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave18.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave19.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave20.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave21.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave22.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave23.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave24.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave25.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave26.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave27.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave28.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave29.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave30.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave31.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave32.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave33.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave34.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave35.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave36.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave37.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave38.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave39.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave40.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave41.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave42.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave43.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave44.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave45.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave46.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave47.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave48.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave49.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "moz2-linux-slave50.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, vm
}

node "mv-moz2-linux-ix-slave02.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave03.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave04.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave05.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave06.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave07.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave08.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave09.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave10.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave11.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave12.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave13.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave14.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave15.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave16.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave17.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave18.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave19.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave20.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave21.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave22.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave23.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave24.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "mv-moz2-linux-ix-slave25.build.mozilla.org" {
    include base, buildslave, cltbld, build-network, ix
}

node "try-linux-slave01.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave02.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave03.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "sm-try-linux-slave04.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave06.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave07.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave08.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave09.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave10.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave11.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave12.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave13.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave14.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave15.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave16.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave17.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave18.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "try-linux-slave19.mozilla.org" {
    include base, buildslave, cltbld, sandbox-network, vm
}

node "bm-mini-build-ref.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave02.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave05.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave06.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave07.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave09.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave10.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave11.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave12.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave13.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave14.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave15.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave16.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave17.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave18.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave19.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave20.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave21.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave22.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave23.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave24.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave25.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave26.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave29.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave30.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave31.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave32.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave33.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave34.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave35.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave36.build.mozilla.org" {
    include base, buildslave, build-network
}

node "moz2-darwin9-slave37.build.mozilla.org" {
    include base, buildslave, build-network
}

node "bm-xserve07.build.mozilla.org" {
    include base, buildslave, build-network
}

node "bm-xserve09.build.mozilla.org" {
    include base, buildslave, build-network
}

node "bm-xserve11.build.mozilla.org" {
    include base, buildslave, build-network
}

node "bm-xserve12.build.mozilla.org" {
    include base, buildslave, build-network
}

node "bm-xserve16.build.mozilla.org" {
    include base, buildslave, build-network
}

node "bm-xserve17.build.mozilla.org" {
    include base, buildslave, build-network
}

node "bm-xserve18.build.mozilla.org" {
    include base, buildslave, build-network
}

node "bm-xserve19.build.mozilla.org" {
    include base, buildslave, build-network
}

node "bm-xserve21.build.mozilla.org" {
    include base, buildslave, build-network
}
node "bm-xserve22.build.mozilla.org" {
    include base, buildslave, build-network
}

node "try-mac-slave01.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave02.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave03.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave04.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave06.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave07.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave08.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave09.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave10.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave11.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave12.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave13.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave14.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave15.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave16.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave17.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave18.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "try-mac-slave19.mozilla.org" {
    include base, buildslave, sandbox-network
}

node "talos-r3-fed-ref.build.mozilla.org" {
}

node "talos-r3-fed-001.build.mozilla.org" {
}

node "talos-r3-fed-002.build.mozilla.org" {
}

node "talos-r3-fed-003.build.mozilla.org" {
}

node "talos-r3-fed-004.build.mozilla.org" {
}

node "talos-r3-fed-005.build.mozilla.org" {
}

node "talos-r3-fed-006.build.mozilla.org" {
}

node "talos-r3-fed-007.build.mozilla.org" {
}

node "talos-r3-fed-008.build.mozilla.org" {
}

node "talos-r3-fed-009.build.mozilla.org" {
}

node "talos-r3-fed-010.build.mozilla.org" {
}

node "talos-r3-fed-011.build.mozilla.org" {
}

node "talos-r3-fed-012.build.mozilla.org" {
}

node "talos-r3-fed-013.build.mozilla.org" {
}

node "talos-r3-fed-014.build.mozilla.org" {
}

node "talos-r3-fed-015.build.mozilla.org" {
}

node "talos-r3-fed-016.build.mozilla.org" {
}

node "talos-r3-fed-017.build.mozilla.org" {
}

node "talos-r3-fed-018.build.mozilla.org" {
}

node "talos-r3-fed-019.build.mozilla.org" {
}

node "talos-r3-fed-020.build.mozilla.org" {
}

node "talos-r3-fed-021.build.mozilla.org" {
}

node "talos-r3-fed-022.build.mozilla.org" {
}

node "talos-r3-fed-023.build.mozilla.org" {
}

node "talos-r3-fed-024.build.mozilla.org" {
}

node "talos-r3-fed-025.build.mozilla.org" {
}

node "talos-r3-fed-026.build.mozilla.org" {
}

node "talos-r3-fed-027.build.mozilla.org" {
}

node "talos-r3-fed-028.build.mozilla.org" {
}

node "talos-r3-fed-029.build.mozilla.org" {
}

node "talos-r3-fed-030.build.mozilla.org" {
}

node "talos-r3-fed-031.build.mozilla.org" {
}

node "talos-r3-fed-032.build.mozilla.org" {
}

node "talos-r3-fed-033.build.mozilla.org" {
}

node "talos-r3-fed-034.build.mozilla.org" {
}

node "talos-r3-fed-035.build.mozilla.org" {
}

node "talos-r3-fed-036.build.mozilla.org" {
}

node "talos-r3-fed-037.build.mozilla.org" {
}

node "talos-r3-fed-038.build.mozilla.org" {
}

node "talos-r3-fed-039.build.mozilla.org" {
}

node "talos-r3-fed-040.build.mozilla.org" {
}

node "talos-r3-fed64-ref.build.mozilla.org" {
}

node "talos-r3-fed64-001.build.mozilla.org" {
}

node "talos-r3-fed64-002.build.mozilla.org" {
}

node "talos-r3-fed64-003.build.mozilla.org" {
}

node "talos-r3-fed64-004.build.mozilla.org" {
}

node "talos-r3-fed64-005.build.mozilla.org" {
}

node "talos-r3-fed64-006.build.mozilla.org" {
}

node "talos-r3-fed64-007.build.mozilla.org" {
}

node "talos-r3-fed64-008.build.mozilla.org" {
}

node "talos-r3-fed64-009.build.mozilla.org" {
}

node "talos-r3-fed64-010.build.mozilla.org" {
}

node "talos-r3-fed64-011.build.mozilla.org" {
}

node "talos-r3-fed64-012.build.mozilla.org" {
}

node "talos-r3-fed64-013.build.mozilla.org" {
}

node "talos-r3-fed64-014.build.mozilla.org" {
}

node "talos-r3-fed64-015.build.mozilla.org" {
}

node "talos-r3-fed64-016.build.mozilla.org" {
}

node "talos-r3-fed64-017.build.mozilla.org" {
}

node "talos-r3-fed64-018.build.mozilla.org" {
}

node "talos-r3-fed64-019.build.mozilla.org" {
}

node "talos-r3-fed64-020.build.mozilla.org" {
}

node "talos-r3-fed64-021.build.mozilla.org" {
}

node "talos-r3-fed64-022.build.mozilla.org" {
}

node "talos-r3-fed64-023.build.mozilla.org" {
}

node "talos-r3-fed64-024.build.mozilla.org" {
}

node "talos-r3-fed64-025.build.mozilla.org" {
}

node "talos-r3-fed64-026.build.mozilla.org" {
}

node "talos-r3-fed64-027.build.mozilla.org" {
}

node "talos-r3-fed64-028.build.mozilla.org" {
}

node "talos-r3-fed64-029.build.mozilla.org" {
}

node "talos-r3-fed64-030.build.mozilla.org" {
}

node "talos-r3-fed64-031.build.mozilla.org" {
}

node "talos-r3-fed64-032.build.mozilla.org" {
}

node "talos-r3-fed64-033.build.mozilla.org" {
}

node "talos-r3-fed64-034.build.mozilla.org" {
}

node "talos-r3-fed64-035.build.mozilla.org" {
}

node "talos-r3-fed64-036.build.mozilla.org" {
}

node "talos-r3-fed64-037.build.mozilla.org" {
}

node "talos-r3-fed64-038.build.mozilla.org" {
}

node "talos-r3-fed64-039.build.mozilla.org" {
}

node "talos-r3-fed64-040.build.mozilla.org" {
}

node "qm-ref-leopard.mozilla.org" {
}

node "talos-r3-leopard-ref.build.mozilla.org" {
}

node "talos-r3-leopard-001.build.mozilla.org" {
}

node "talos-r3-leopard-002.build.mozilla.org" {
}

node "talos-r3-leopard-003.build.mozilla.org" {
}

node "talos-r3-leopard-004.build.mozilla.org" {
}

node "talos-r3-leopard-005.build.mozilla.org" {
}

node "talos-r3-leopard-006.build.mozilla.org" {
}

node "talos-r3-leopard-007.build.mozilla.org" {
}

node "talos-r3-leopard-008.build.mozilla.org" {
}

node "talos-r3-leopard-009.build.mozilla.org" {
}

node "talos-r3-leopard-010.build.mozilla.org" {
}

node "talos-r3-leopard-011.build.mozilla.org" {
}

node "talos-r3-leopard-012.build.mozilla.org" {
}

node "talos-r3-leopard-013.build.mozilla.org" {
}

node "talos-r3-leopard-014.build.mozilla.org" {
}

node "talos-r3-leopard-015.build.mozilla.org" {
}

node "talos-r3-leopard-016.build.mozilla.org" {
}

node "talos-r3-leopard-017.build.mozilla.org" {
}

node "talos-r3-leopard-018.build.mozilla.org" {
}

node "talos-r3-leopard-019.build.mozilla.org" {
}

node "talos-r3-leopard-020.build.mozilla.org" {
}

node "talos-r3-leopard-021.build.mozilla.org" {
}

node "talos-r3-leopard-022.build.mozilla.org" {
}

node "talos-r3-leopard-023.build.mozilla.org" {
}

node "talos-r3-leopard-024.build.mozilla.org" {
}

node "talos-r3-leopard-025.build.mozilla.org" {
}

node "talos-r3-leopard-026.build.mozilla.org" {
}

node "talos-r3-leopard-027.build.mozilla.org" {
}

node "talos-r3-leopard-028.build.mozilla.org" {
}

node "talos-r3-leopard-029.build.mozilla.org" {
}

node "talos-r3-leopard-030.build.mozilla.org" {
}

node "talos-r3-leopard-031.build.mozilla.org" {
}

node "talos-r3-leopard-032.build.mozilla.org" {
}

node "talos-r3-leopard-033.build.mozilla.org" {
}

node "talos-r3-leopard-034.build.mozilla.org" {
}

node "talos-r3-leopard-035.build.mozilla.org" {
}

node "talos-r3-leopard-036.build.mozilla.org" {
}

node "talos-r3-leopard-037.build.mozilla.org" {
}

node "talos-r3-leopard-038.build.mozilla.org" {
}

node "talos-r3-leopard-039.build.mozilla.org" {
}

node "talos-r3-leopard-040.build.mozilla.org" {
}

node default {
    #include base
}


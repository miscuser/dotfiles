#-------------------------------------------------------------------------------
#  Use python as a calculator by including the math library.
#-------------------------------------------------------------------------------
calc(){
    #python3 -c "from math import *; print($*)"
    python -c "from __future__ import division; from math import *; print($*)"
}

#-------------------------------------------------------------------------------
#  Change to directory immediately after creating it.
#-------------------------------------------------------------------------------
function mkdircd() {
    mkdir -p "$@" && eval cd "\"\$$#\"";
}

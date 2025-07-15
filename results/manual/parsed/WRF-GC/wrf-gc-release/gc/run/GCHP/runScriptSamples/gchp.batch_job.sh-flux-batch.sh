#!/bin/bash
#FLUX: --job-name=conspicuous-pot-4033
#FLUX: --urgency=16

set -e
set -x
ulimit -c 0                  # coredumpsize
ulimit -l unlimited          # memorylocked
ulimit -u 50000              # maxproc
ulimit -v unlimited          # vmemoryuse
ulimit -s unlimited          # stacksize
module list     
start_str=$(sed 's/ /_/g' cap_restart)
log=gchp.${start_str:0:13}z.log
source setCommonRunSettings.sh
source setRestartLink.sh
source checkRunSettings.sh
new_start_str=$(sed 's/ /_/g' cap_restart)
if [[ "${new_start_str}" = "${start_str}" || "${new_start_str}" = "" ]]; then
   echo "ERROR: GCHP failed to run to completion. Check the log file for more information."
   exit 1
else
    N=$(grep "CS_RES=" setCommonRunSettings.sh | cut -c 8- | xargs )    
    mv gcchem_internal_checkpoint Restarts/GEOSChem.Restart.${new_start_str:0:13}z.c${N}.nc4
    source setRestartLink.sh
fi

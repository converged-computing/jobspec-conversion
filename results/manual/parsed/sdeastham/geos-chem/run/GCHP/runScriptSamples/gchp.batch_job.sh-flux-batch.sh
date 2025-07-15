#!/bin/bash
#FLUX: --job-name=reclusive-gato-9568
#FLUX: --priority=16

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
chkpnts=$(ls Restarts)
for chkpnt in ${chkpnts}
do
    if [[ "$chkpnt" == *"gcchem_internal_checkpoint."* ]]; then
       chkpnt_time=${chkpnt:27:13}
       if [[ "${chkpnt_time}" = "${start_str:0:13}" ]]; then
          rm ./Restarts/${chkpnt}
       else
          new_chkpnt=./Restarts/GEOSChem.Restart.${chkpnt_time}z.c${N}.nc4
          mv ./Restarts/${chkpnt} ${new_chkpnt}
       fi
    fi
done
new_start_str=$(sed 's/ /_/g' cap_restart)
if [[ "${new_start_str}" = "${start_str}" || "${new_start_str}" = "" ]]; then
    echo "ERROR: GCHP failed to run to completion. Check the log file for more information."
    rm -f Restarts/gcchem_internal_checkpoint
    exit 1
else
    N=$(grep "CS_RES=" setCommonRunSettings.sh | cut -c 8- | xargs )
    mv Restarts/gcchem_internal_checkpoint Restarts/GEOSChem.Restart.${new_start_str:0:13}z.c${N}.nc4
    source setRestartLink.sh
fi

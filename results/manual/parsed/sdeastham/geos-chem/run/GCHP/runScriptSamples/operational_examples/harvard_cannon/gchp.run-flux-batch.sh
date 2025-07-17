#!/bin/bash
#FLUX: --job-name=muffled-itch-7714
#FLUX: -N=2
#FLUX: -n=96
#FLUX: --exclusive
#FLUX: --queue=huce_intel,seas_compute,shared
#FLUX: -t=480
#FLUX: --urgency=16

export OMPI_MCL_btl='openib'

set -xe
start_str=$(sed 's/ /_/g' cap_restart)
log=gchp.${start_str:0:13}z.log
echo "Writing output to ${log}"
source setCommonRunSettings.sh > ${log}
source setRestartLink.sh >> ${log}
source gchp.env >> ${log}
source checkRunSettings.sh >> ${log}
export OMPI_MCL_btl=openib
NX=$( grep NX GCHP.rc | awk '{print $2}' )
NY=$( grep NY GCHP.rc | awk '{print $2}' )
coreCount=$(( ${NX} * ${NY} ))
planeCount=$(( ${coreCount} / ${SLURM_NNODES} ))
if [[ $(( ${coreCount} % ${SLURM_NNODES} )) > 0 ]]; then
    planeCount=$(( ${planeCount} + 1 ))
fi
time srun -n ${coreCount} -N ${SLURM_NNODES} -m plane=${planeCount} --mpi=pmix ./gchp >> ${log}
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
exit 0

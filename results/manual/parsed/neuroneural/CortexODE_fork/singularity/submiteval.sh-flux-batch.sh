#!/bin/bash
#FLUX: --job-name=placid-arm-2406
#FLUX: --urgency=16

sleep 5s
module load singularity/3.10.2
singularity exec --nv --bind /data/users2/washbee/speedrun/:/speedrun,/data/users2/washbee/speedrun/CortexODE_fork:/cortexode /data/users2/washbee/containers/speedrun/cortexODE_bm_sandbox/ /cortexode/singularity/eval.sh &
wait
sleep 10s

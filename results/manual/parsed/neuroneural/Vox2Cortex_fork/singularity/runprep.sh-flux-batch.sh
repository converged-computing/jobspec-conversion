#!/bin/bash
#FLUX: --job-name=expensive-pastry-0512
#FLUX: --urgency=16

sleep 5s
module load singularity/3.10.2
singularity exec --nv --bind /data,/data/users2/washbee/speedrun/Vox2Cortex_fork/:/v2c,/data/users2/washbee/speedrun/v2c-data:/subj /data/users2/washbee/containers/speedrun/v2c_sr.sif /v2c/singularity/prep.sh &
wait

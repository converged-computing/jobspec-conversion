#!/bin/bash
#FLUX: --job-name=salted-carrot-4954
#FLUX: --urgency=16

sleep 5s
singularity exec --nv --bind /data:/data/,/home:/home/,/home/users/washbee1/projects/deepcsr:/deepcsr/,/data/users2/washbee/outdir:/subj /data/users2/washbee/containers/deepcsr.sif /deepcsr/singularity/train.sh &
wait
sleep 10s

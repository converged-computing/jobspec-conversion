#!/bin/bash
#FLUX: --job-name=pusheena-car-7745
#FLUX: -n=64
#FLUX: --queue=t1standard
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
srun -l /bin/hostname | sort -n | awk '{print $2}' > ./nodes.$SLURM_JOB_ID
make streams
rm ./nodes.$SLURM_JOB_ID

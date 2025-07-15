#!/bin/bash
#FLUX: --job-name=crusty-noodle-0085
#FLUX: -n=64
#FLUX: --queue=t1standard
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
srun -l /bin/hostname | sort -n | awk '{print $2}' > ./nodes.$SLURM_JOB_ID
make streams
rm ./nodes.$SLURM_JOB_ID

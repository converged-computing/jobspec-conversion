#!/bin/bash
#FLUX: --job-name=psycho-noodle-0051
#FLUX: -c=16
#FLUX: --queue=AMG
#FLUX: -t=86400
#FLUX: --urgency=16

echo 'JOB_NAME' $SLURM_JOB_NAME
echo 'JOB_ID' $SLURM_JOB_ID
echo 'JOB_CPUS_PER_NODE' $SLURM_JOB_CPUS_PER_NODE
hostname
date
module load Compiler/Intel/17u8 Q-Ch/ABINIT/8.10.3/intel/2017u8
cd ~/abinit
mpirun -np $SLURM_JOB_CPUS_PER_NODE abinit < $SLURM_JOB_NAME.files > $SLURM_JOB_NAME.log
date
rm -f ~/$SLURM_JOB_NAME.e$SLURM_JOB_ID.err

#!/bin/bash
#FLUX: --job-name=clump
#FLUX: --queue=dphys_compute
#FLUX: -t=86400
#FLUX: --urgency=16

echo "Starting at `date`"
echo "Running on hosts: $SLURM_NODELIST"
echo "Running on $SLURM_NNODES nodes."
echo "Running on $SLURM_NPROCS processors."
echo "Running on $SLURM_JOB_CPUS_PER_NODE cpus per node."
echo "Current working directory is `pwd`"
cd $HOME
path=$1
length=320
module load python/2.7.6-gcc-4.8.1
index=${SLURM_ARRAY_TASK_ID}
cd /users/sibirrer/Lenstronomy/lenstronomy/Sensitivity/
python monch_array_script.py $path $index $length
echo "Ending at `date`"

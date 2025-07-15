#!/bin/bash
#FLUX: --job-name=tf_unet
#FLUX: -t=7140
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/apps/daint/UES/5.2.UP04/sandbox-ds/tensorflow/cudadnn/lib64/:$LD_LIBRARY_PATH'

echo "Starting at `date`"
echo "Running on hosts: $SLURM_NODELIST"
echo "Running on $SLURM_NNODES nodes."
echo "Running on $SLURM_NPROCS processors."
echo "Running on $SLURM_JOB_CPUS_PER_NODE cpus per node."
echo "Current working directory is `pwd`"
source $SCRATCH/virtualenvs/env-tensorflow-0.9.0/bin/activate
export LD_LIBRARY_PATH=/apps/daint/UES/5.2.UP04/sandbox-ds/tensorflow/cudadnn/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/apps/daint/UES/5.2.UP04/sandbox-ds/tensorflow/cudadnn/lib64/:$LD_LIBRARY_PATH
module list
which python
srun time python ../scripts/launcher.py

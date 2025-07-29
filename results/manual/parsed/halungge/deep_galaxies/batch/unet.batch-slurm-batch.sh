#!/bin/bash
#SBATCH --job-name=tf_unet
#SBATCH --output=tf_unet.%j.o
#SBATCH --error=tf_unet.%j.e
#SBATCH --mail-user=jakeret
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:59:00

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

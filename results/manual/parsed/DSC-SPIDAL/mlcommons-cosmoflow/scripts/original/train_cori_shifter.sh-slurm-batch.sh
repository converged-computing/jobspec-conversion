#!/bin/bash
#SBATCH --job-name=train-cori
#SBATCH --output=logs/%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

singularity
exec
docker:sfarrell/cosmoflow-cpu-mpich:latest
module load singularity tensorflow/2.8.0
singularity run \
    --nv $CONTAINERDIR/tensorflow-2.8.0.sif \
    --env=OMP_NUM_THREADS=32,KMP_BLOCKTIME=1,KMP_AFFINITY="granularity=fine,compact,1,0",HDF5_USE_FILE_LOCKING=FALSE
  train.py \
    --config=../configs/cosmo.yaml 

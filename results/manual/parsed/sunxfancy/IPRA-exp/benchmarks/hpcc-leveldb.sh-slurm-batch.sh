#!/bin/bash
#FLUX: --job-name=ipra-leveldb
#FLUX: -c=32
#FLUX: --queue=short
#FLUX: -t=3600
#FLUX: --urgency=16

module load singularity
echo $SLURM_PROCID-$SLURM_JOBID
echo Build leveldb: $1
echo Action: $2
shopt -s extglob
rm -vrf /scratch/!(xsun042)
singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/leveldb/$1
if [[ "$2" != "" ]]; then
    singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/leveldb/$1.$2
    if [[ "$1" == *"fdoipra"* ]]; then
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/leveldb/$1.1-10.$2
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/leveldb/$1.1-20.$2
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/leveldb/$1.3-10.$2
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/leveldb/$1.3-20.$2
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/leveldb/$1.5-10.$2
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/leveldb/$1.5-20.$2
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/leveldb/$1.10-10.$2
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/leveldb/$1.10-20.$2
    fi
fi

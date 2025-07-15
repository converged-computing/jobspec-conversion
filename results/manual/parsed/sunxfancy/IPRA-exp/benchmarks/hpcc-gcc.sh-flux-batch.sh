#!/bin/bash
#FLUX: --job-name=ipra-gcc
#FLUX: -c=32
#FLUX: -t=7200
#FLUX: --urgency=16

module load singularity
echo $SLURM_PROCID-$SLURM_JOBID
echo Build gcc: $1
echo Action: $2
shopt -s extglob
rm -vrf /scratch/!(xsun042)
singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/gcc/$1
if [[ "$2" != "" ]]; then
    singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/gcc/$1.$2
    if [[ "$1" == *"fdoipra"* ]]; then
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/gcc/$1.1-10.$2
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/gcc/$1.1-20.$2
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/gcc/$1.3-10.$2
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/gcc/$1.3-20.$2
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/gcc/$1.5-10.$2
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/gcc/$1.5-20.$2
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/gcc/$1.10-10.$2
        singularity exec singularity/image.sif make BUILD_PATH=/scratch/xsun042/$SLURM_JOBID benchmarks/gcc/$1.10-20.$2
    fi
fi

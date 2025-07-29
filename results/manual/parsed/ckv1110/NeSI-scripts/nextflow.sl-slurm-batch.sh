#!/bin/bash
#SBATCH --job-name=nf-T71
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=280GB
#SBATCH --time=00:40:00
#SBATCH --partition=hgx

export SINGULARITY_CACHEDIR='/nesi/nobackup/uoa03709/containers/apptainer_cache'
export SINGULARITY_TMPDIR='/nesi/nobackup/uoa03709/containers/apptainer_tmpdir'

module purge
module load Singularity
module load Nextflow
export SINGULARITY_CACHEDIR=/nesi/nobackup/uoa03709/containers/apptainer_cache
export SINGULARITY_TMPDIR=/nesi/nobackup/uoa03709/containers/apptainer_tmpdir
mkdir -p $SINGULARITY_CACHEDIR $SINGULARITY_TMPDIR
setfacl -b $SINGULARITY_TMPDIR
nextflow run ckv1110/mcmicro --in T71GBM12_001/reg2 -profile singularity

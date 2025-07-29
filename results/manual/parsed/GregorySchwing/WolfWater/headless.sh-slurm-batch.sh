#!/bin/bash
#SBATCH --job-name=NXTFLW
#SBATCH --output=output_%j.out
#SBATCH --error=errors_%j.err
#SBATCH --mail-user=go2432@wayne.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=14-00:00:00

export NXF_EXECUTOR='slurm'
export NXF_OPTS='-Xms2G -Xmx8G" '
export NXF_SINGULARITY_CACHEDIR='${HOME}/singularity_cache'
export XDG_RUNTIME_DIR='${HOME}/xdr'

source "${HOME}/mambaforge/etc/profile.d/mamba.sh"
source activate nextflow
mamba activate nextflow
which nextflow
which singularity
export NXF_EXECUTOR=slurm
export NXF_OPTS="-Xms2G -Xmx8G" 
mkdir -p ${HOME}/singularity_cache
export NXF_SINGULARITY_CACHEDIR=${HOME}/singularity_cache
mkdir -p ${HOME}/xdr
export XDG_RUNTIME_DIR=${HOME}/xdr
nextflow run -profile slurm . --param_name nextflow.config -resume

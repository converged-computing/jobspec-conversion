#!/bin/bash
#SBATCH --job-name=test_slurm
#SBATCH --output=./fitlogs/job.out.%j
#SBATCH --error=./fitlogs/job.err.%j
#SBATCH --mail-user=userid@example.mpg.de
#SBATCH --mail-type=none
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000MB
#SBATCH --time=2-00:00:00
#SBATCH --partition=long
#SBATCH --constraint=ntasks-per-node=4
#SBATCH --chdir=./

export SINGULARITY_TMPDIR='$(pwd)/tmp'
export SINGULARITY_CACHEDIR='$(pwd)/tmp'

module purge
module load apptainer
export SINGULARITY_TMPDIR=$(pwd)/tmp
export SINGULARITY_CACHEDIR=$(pwd)/tmp
set -x
mkdir -p CABCHSV fitresults pseudodata
srun  singularity exec -B $(pwd):$(pwd) --env JULIA_DEPOT_PATH=$(pwd)/J:/opt/julia docker://ghcr.io/mppmu/high-x-parton-pdf-inference:latest $JULIA  "$@"

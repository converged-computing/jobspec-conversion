#!/bin/bash
#SBATCH --job-name=RiboPrint
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=150g
#SBATCH --time=01:00:00

export NXF_SINGULARITY_CACHEDIR='$PWD/.singularity'
export SINGULARITY_CACHEDIR='$PWD/.singularity'

module load singularity
module load nextflow
module load ucsc
module load bedtools
module load R
export NXF_SINGULARITY_CACHEDIR=$PWD/.singularity
export SINGULARITY_CACHEDIR=$PWD/.singularity
mkdir -p Results
ResumeArg=$1
nextflow run RiboFootPrint.nf --workdir $PWD  -c nextflow.config -params-file RiboFootPrint.parameters.yaml  ${ResumeArg} 

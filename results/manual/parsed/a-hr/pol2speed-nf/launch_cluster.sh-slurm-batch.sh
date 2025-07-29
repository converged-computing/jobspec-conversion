#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=20:00:00

export NXF_OPTS='-Xms500M -Xmx8G'

module load Singularity Nextflow Go
export NXF_OPTS="-Xms500M -Xmx8G"
nextflow run main.nf -resume -profile cluster -params-file input_params.yaml

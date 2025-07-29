#!/bin/bash
#SBATCH --job-name=resume_nf
#SBATCH --mail-user=gbirzu@stanford.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00

WORKFLOW=$1
PROFILE=$2
ml ncbi-blast+
nextflow run ${WORKFLOW} -profile ${PROFILE} -resume

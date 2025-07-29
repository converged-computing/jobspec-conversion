#!/bin/bash
#SBATCH --account=asbhatt
#SBATCH --output=/labs/asbhatt/wirbel/SCRATCH/preprocessing_nf.out
#SBATCH --error=/labs/asbhatt/wirbel/SCRATCH/preprocessing_nf.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=12G
#SBATCH --time=10-00:00:00

module load java/18.0.2.1
module load nextflow/22.10.5
nextflow run /labs/asbhatt/wirbel/AWIgen2/AWIGen2Microbiome/workflows/preprocessing.nf \
	-c /labs/asbhatt/wirbel/AWIgen2/AWIGen2Microbiome/workflows/config/run_preprocessing.config \
	-params-file /labs/asbhatt/wirbel/AWIgen2/AWIGen2Microbiome/workflows/config/params.yml \
	-with-trace -with-report -resume

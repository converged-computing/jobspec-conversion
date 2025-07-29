#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --output=snakelog.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00

source activate dropseq
bash /project2/gilad/spott/Pipelines/dropseq_pipeline/Submit_snakemake.sh $*

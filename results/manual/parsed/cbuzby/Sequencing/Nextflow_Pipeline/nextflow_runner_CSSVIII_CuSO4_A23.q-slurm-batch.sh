#!/bin/bash
#SBATCH --job-name=nf_full
#SBATCH --output=slurm_full.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB
#SBATCH --time=4-04:00:00

module purge
module load nextflow/20.10.0
cd /scratch/cb4097/Sequencing/
nextflow run /scratch/cb4097/Sequencing/NEXTFLOW_TESTING/TrimAlignSortBQSR_All.nf -resume -c /scratch/cb4097/Sequencing/NEXTFLOW_TESTING/nextflow.CSS8_CuSO4_Apr23.config -with-timeline timeline_full.html -with-report report_full.html

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
cd /scratch/yp19/sequencing_analysis/VariantCall_Full/
nextflow run /scratch/yp19/sequencing_analysis/nf_scripts/filepair_input_pipeline.nf -resume -params-file /scratch/yp19/sequencing_analysis/nf_scripts/param_file.yaml -with-timeline timeline_full.html -with-report report_full.html

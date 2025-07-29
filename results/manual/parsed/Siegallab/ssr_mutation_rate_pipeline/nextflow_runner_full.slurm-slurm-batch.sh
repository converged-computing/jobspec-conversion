#!/bin/bash
#SBATCH --job-name=nf_full
#SBATCH --output=slurm_full.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB
#SBATCH --time=4-04:00:00

main_dir='/scratch/yp19/plavskin_seq_analysis'
nf_dir="${main_dir}/nf_scripts"
module purge
module load nextflow/20.10.0
cd $main_dir
nextflow run ${nf_dir}/sra_file_input_pipeline.nf -resume -with-timeline timeline_full.html -with-report report_full.html

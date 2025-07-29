#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=12gb
#SBATCH --time=1-12:00:00
#SBATCH --partition=exacloud
#SBATCH --chdir=/home/groups/CEDAR/mulqueen/bc_multiome

module load singularity/3.8.0 #load singularity
module load nextflow/21.10.1 #load nextflow
proj_dir="/home/groups/CEDAR/mulqueen/bc_multiome"
bed="/home/groups/CEDAR/mulqueen/bc_multiome/merged.nf.bed"
nextflow run \
bc_multiome_nf_analysis/nextflow_version/bc_multiome.nf.groovy \
--merged_bed ${proj_dir}/merged.nf.bed \
--outdir ${proj_dir}/nf_analysis_round3 \
--sample_dir ${proj_dir}/cellranger_data/third_round \
-resume

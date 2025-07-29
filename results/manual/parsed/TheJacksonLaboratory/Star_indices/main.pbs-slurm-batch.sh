#!/bin/bash
#SBATCH --output=splicing.%j.out
#SBATCH --error=splicing.%j.err
#SBATCH --mail-user=$USER@jax.org
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=35000
#SBATCH --time=1-00:00:00
#SBATCH --partition=batch

cd $SLURM_SUBMIT_DIR
date;hostname;pwd
module load singularity
curl -fsSL get.nextflow.io | bash
./nextflow run /projects/anczukow-lab/star_index_pipeline/Star_indices/main.nf \
	--outdir ${SLURM_SUBMIT_DIR} \
	-config NF_Star_Index.config \
	-profile sumner -resume \
        -with-report report.html \
        -with-timeline timeline.html 

#!/bin/bash
#SBATCH --output=splicing.%j.out
#SBATCH --error=splicing.%j.err
#SBATCH --mail-user=$USER@jax.org
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20000
#SBATCH --time=3-00:00:00
#SBATCH --partition=batch

cd $SLURM_SUBMIT_DIR
date;hostname;pwd
module load singularity
curl -fsSL get.nextflow.io | bash
./nextflow run /projects/anczukow-lab/splicing_pipeline/splicing-pipelines-nf/main.nf \
	--outdir ${SLURM_SUBMIT_DIR} \
	-config NF_splicing_pipeline.config \
	-profile sumner -resume \
        -with-report report.html \
        -with-trace trace.txt \
        -with-timeline timeline.html \
        -with-dag DAG.png

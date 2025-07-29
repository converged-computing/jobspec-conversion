#!/bin/bash
#SBATCH --output=splicing.%j.out
#SBATCH --error=splicing.%j.err
#SBATCH --mail-user=$USER@jax.org
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20000
#SBATCH --time=2-09:00:00

cd $SLURM_SUBMIT_DIR
date;hostname;pwd
module load singularity
curl -fsSL get.nextflow.io | bash
./nextflow run /projects/anczukow-lab/splicing_pipeline/splicing-pipelines-nf/main.nf \
	-config /projects/anczukow-lab/splicing_pipeline/splicing-pipelines-nf/conf/examples/human_test.config  \
	--outdir ${SLURM_SUBMIT_DIR} \
	-profile sumner -resume \
	-with-report human_test.html \
	-with-timeline human_test_timeline.html 

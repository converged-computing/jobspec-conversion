#!/bin/bash
#FLUX: --job-name=pps
#FLUX: -t=259200
#FLUX: --urgency=16

mkdir /flashscratch/fastq_$SLURM_ARRAY_TASK_ID
cd /flashscratch/fastq_$SLURM_ARRAY_TASK_ID
module load singularity
cp $SLURM_SUBMIT_DIR/Snakefile .
singularity exec /projects/chesler-lab/jcpg/snakemake/sing.sif bash $SLURM_SUBMIT_DIR/run_snakemake.sh $SLURM_SUBMIT_DIR/case_control_c${SLURM_ARRAY_TASK_ID}.tsv /flashscratch/fastq_$SLURM_ARRAY_TASK_ID

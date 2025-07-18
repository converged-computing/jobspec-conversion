#!/bin/bash
#FLUX: --job-name=pps
#FLUX: -n=32
#FLUX: -t=259200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR/fastq_$SLURM_ARRAY_TASK_ID
module load singularity
cp ../Snakefile .
singularity exec ../sing.sif bash ../run_snakemake.sh ../case_control_c${SLURM_ARRAY_TASK_ID}.tsv /Snakemake/fastq_$SLURM_ARRAY_TASK_ID

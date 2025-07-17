#!/bin/bash
#FLUX: --job-name=pps
#FLUX: -n=31
#FLUX: -t=259200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load singularity
singularity exec sing.sif bash run_snakemake.sh 

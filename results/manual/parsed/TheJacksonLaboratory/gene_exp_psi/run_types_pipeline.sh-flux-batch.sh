#!/bin/bash
#FLUX: --job-name="pps"
#FLUX: -t=259200
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
module load singularity
singularity exec sing.sif bash run_snakemake.sh 

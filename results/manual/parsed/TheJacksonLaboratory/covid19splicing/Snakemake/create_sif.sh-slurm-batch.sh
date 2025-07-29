#!/bin/bash
#FLUX: --job-name=pps
#FLUX: -t=7200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load singularity
singularity run http://s3-far.jax.org/builder/builder sing_img.def sing.sif

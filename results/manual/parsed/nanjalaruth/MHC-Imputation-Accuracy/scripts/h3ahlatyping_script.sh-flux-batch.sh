#!/bin/bash
#FLUX: --job-name='h3ahlatyping'
#FLUX: -c=2
#FLUX: -t=1209600
#FLUX: --priority=16

cd /scratch3/users/nanje/hlatyping/h3a_hlatypes
echo "Submitting SLURM job"
nextflow -c /users/nanje/Africanpop/h3a.config run nanjalaruth/hlatyping -profile singularity,slurm --input "/cbio/projects/013/custom-bam/*/*.bam" -resume

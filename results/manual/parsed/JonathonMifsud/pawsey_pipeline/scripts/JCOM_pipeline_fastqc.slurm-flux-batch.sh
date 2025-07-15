#!/bin/bash
#FLUX: --job-name=fastqc
#FLUX: --queue=work
#FLUX: -t=172800
#FLUX: --urgency=16

export library_run='${myarray["$SLURM_ARRAY_TASK_ID"]}'

module load singularity/3.11.4
cd /scratch/director2187/$user/jcomvirome/"$project"/fastqc
readarray -t myarray < "$file_of_accessions"
export library_run=${myarray["$SLURM_ARRAY_TASK_ID"]}
singularity exec "$singularity_image" fastqc "$library_run" \
    --format fastq \
    --threads 4 \
    --outdir /scratch/director2187/$user/jcomvirome/"$project"/fastqc

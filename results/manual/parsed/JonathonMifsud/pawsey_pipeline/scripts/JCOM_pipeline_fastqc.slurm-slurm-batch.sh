#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --mail-user=$user@uni.sydney.edu.au
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=4

export library_run='${myarray["$SLURM_ARRAY_TASK_ID"]}'

module load singularity/3.11.4
cd /scratch/director2187/$user/jcomvirome/"$project"/fastqc
readarray -t myarray < "$file_of_accessions"
export library_run=${myarray["$SLURM_ARRAY_TASK_ID"]}
singularity exec "$singularity_image" fastqc "$library_run" \
    --format fastq \
    --threads 4 \
    --outdir /scratch/director2187/$user/jcomvirome/"$project"/fastqc

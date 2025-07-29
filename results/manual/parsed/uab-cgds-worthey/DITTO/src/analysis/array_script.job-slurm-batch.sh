#!/bin/bash
#SBATCH --job-name=sort
#SBATCH --output=logs/%x_%A_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=6-06:00:00
#SBATCH --array=0-23

module load BCFtools/1.12-GCC-10.2.0
n=$SLURM_ARRAY_TASK_ID # number of jobs in the array
FILES=(/data/project/worthey_lab/projects/experimental_pipelines/tarun/DITTO/data/processed/sorted/*)
gene=${FILES[$SLURM_ARRAY_TASK_ID]}
echo "${gene##*/}"
sort -t$'\t' -k1,1 -k2,2n -T $USER_SCRATCH /data/project/worthey_lab/projects/experimental_pipelines/tarun/DITTO/data/processed/all_snv/${gene##*/} >/data/project/worthey_lab/projects/experimental_pipelines/tarun/DITTO/data/processed/sorted/${gene##*/}
bgzip ${gene##*/}

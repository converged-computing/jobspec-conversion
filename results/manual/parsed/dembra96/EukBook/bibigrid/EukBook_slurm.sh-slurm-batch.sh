#!/bin/bash
#SBATCH --job-name=EukBook
#SBATCH --output=/home/ubuntu/EukBook_slurm-%A_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --array=70-84,86-100

echo "SLURM_ARRAY_TASK_ID is:  ${SLURM_ARRAY_TASK_ID}"
source ~/.profile #to activate conda 
workdir="/mnt/samples/simple"
mkdir -p $workdir
sample_yaml_dir="/home/ubuntu/vol/spool/new_accession_yamls"
cd ~/EukBook
./Snakemake --configfile ${sample_yaml_dir}/set_${SLURM_ARRAY_TASK_ID}.yaml --config Quick_mode=False -k 

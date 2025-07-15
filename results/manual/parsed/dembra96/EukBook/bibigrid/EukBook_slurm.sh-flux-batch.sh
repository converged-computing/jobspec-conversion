#!/bin/bash
#FLUX: --job-name=EukBook
#FLUX: --priority=16

echo "SLURM_ARRAY_TASK_ID is:  ${SLURM_ARRAY_TASK_ID}"
source ~/.profile #to activate conda 
workdir="/mnt/samples/simple"
mkdir -p $workdir
sample_yaml_dir="/home/ubuntu/vol/spool/new_accession_yamls"
cd ~/EukBook
./Snakemake --configfile ${sample_yaml_dir}/set_${SLURM_ARRAY_TASK_ID}.yaml --config Quick_mode=False -k 

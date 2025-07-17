#!/bin/bash
#FLUX: --job-name=dum
#FLUX: --queue=debug
#FLUX: -t=3600
#FLUX: --urgency=16

script_name='dummy' ##name of python script to run
output_dir="LOGS/$script_name"
mkdir -p $output_dir
exec > "$output_dir/${SLURM_JOB_ID}_${SLURM_ARRAY_TASK_ID}.log" 2>&1
date
hostname
source /scratch/apalaci6/miniconda3/bin/activate lalor0
python /scratch/apalaci6/columbia_sz/code/$script_name.py

#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: --queue=cpu
#FLUX: -t=86399
#FLUX: --priority=16

source ~/.bashrc
conda activate ltls
module load analytics cuda11.3/toolkit/11.3.0
run_id=initial
model_id=cpu_a
data_source=model_prep
log_dir=log/${data_source}_${run_id}_${model_id}
mkdir -p ${log_dir}
snakemake --cluster "sbatch -A watertemp -t 01:59:59 -p cpu -N 1 -n 1 -c 1 --job-name=${data_source}_${run_id}_${model_id} -e ${log_dir}/slurm-%j.out -o ${log_dir}/slurm-%j.out" --printshellcmds --keep-going --cores all --jobs 8 --rerun-incomplete train_models 2>&1 | tee ${log_dir}/run.out
snakemake --cluster "sbatch -A watertemp -t 23:59:59 -p cpu -N 1 -n 1 -c 1 --job-name=${data_source}_${run_id}_${model_id} -e ${log_dir}/slurm-%j.out -o ${log_dir}/slurm-%j.out" --printshellcmds --keep-going --cores all --jobs 8 --rerun-incomplete 3_train/out/${data_source}/${run_id}/${model_id}_weights.pt 2>&1 | tee ${log_dir}/run.out

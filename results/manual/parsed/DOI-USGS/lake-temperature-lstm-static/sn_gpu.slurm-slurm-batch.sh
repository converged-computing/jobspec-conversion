#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --account=watertemp
#SBATCH --output=log/sbatch_all_%a_%A.out
#SBATCH --error=log/sbatch_all_%a_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:59:59

source ~/.bashrc
conda activate ltls
module load analytics cuda11.3/toolkit/11.3.0
run_id=initial1
model_id=gpu_a
log_dir=log/${run_id}_${model_id}
mkdir -p ${log_dir}
snakemake --cluster "sbatch -A watertemp -t 00:20:00 -p gpu -N 1 -n 1 -c 1 --job-name=${run_id}_${model_id} --gres=gpu:1 -e ${log_dir}/slurm-%j.out -o ${log_dir}/slurm-%j.out" --printshellcmds --keep-going --cores all --jobs 8 --rerun-incomplete 3_train/out/mntoha/${run_id}/${model_id}_weights.pt 2>&1 | tee ${log_dir}/run.out

#!/bin/bash
#SBATCH --mail-user=abeukers@princeton.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:2
#SBATCH --time=1-16:00:00
#SBATCH --constraint=ntasks-per-node=1,ntasks-per-socket=2

wd_dir="/tigress/abeukers/wd/w2v"
module load anaconda3/4.4.0
module load cudnn/cuda-8.0/6.0
corpus_fpath="${1}"
results_dir="${2}"
printf "\n --corp_fpath is ${corpus_fpath}"
printf "\n --results_dir is ${results_dir}"
srun python ${wd_dir}/w2v3_gpu.py "${corpus_fpath}" "${results_dir}"
printf "\n\nGPU profiling \n\n"
nvidia-smi --query-accounted-apps=gpu_serial,gpu_utilization,mem_utilization,max_memory_usage,time\
			--format=csv

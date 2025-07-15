#!/bin/bash
#FLUX: --job-name=fat-leader-3098
#FLUX: --urgency=16

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

#!/bin/bash
#FLUX: --job-name=carnivorous-squidward-3563
#FLUX: --urgency=16

printf "\n\n\n --ntasks-per-node=1 -c=8 ntasks-per-socket=4 \n\n\n"
seed=${1}
signal=${2}
pmweight=${3}
EM=${4}
pmtrials=${5}
module load anaconda3/4.4.0
module load cudnn/cuda-9.1/7.1.2
printf "\n\n PM Task \n\n"
srun python -u "/tigress/abeukers/wd/pm/pmtask.py" ${seed} ${signal} ${noise} ${pmweight} ${EM} ${pmtrials}
printf "\n\nGPU profiling \n\n"
sacct --format="elapsed,CPUTime,TotalCPU"
nvidia-smi --query-accounted-apps=gpu_serial,gpu_utilization,mem_utilization,max_memory_usage --format=csv

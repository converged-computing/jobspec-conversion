#!/bin/bash
#FLUX: --job-name=hairy-egg-5000
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --urgency=16

printf "\n\n\n --ntasks-per-node=1 -c=8 ntasks-per-socket=4 \n\n\n"
CELLSIZE=${1}
module load anaconda3/4.4.0
module load cudnn/cuda-9.1/7.1.2
module load openmpi/gcc/2.1.0/64 # srm
printf "\n\n NBack Task \n\n"
srun python -u "/tigress/abeukers/wd/epm/train_and_save.py" ${CELLSIZE} 
printf "\n\nGPU profiling \n\n"
sacct --format="elapsed,CPUTime,TotalCPU"
nvidia-smi --query-accounted-apps=gpu_serial,gpu_utilization,mem_utilization,max_memory_usage --format=csv

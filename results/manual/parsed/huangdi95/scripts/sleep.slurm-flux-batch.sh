#!/bin/bash
#FLUX: --job-name=chunky-diablo-3189
#FLUX: --urgency=16

echo "Job start at $(date "+%Y-%m-%d %H:%M:%S")"
echo "Job run at:"
echo "$(hostnamectl)"
source /tools/module_env.sh
module list                       # list modules loaded by default
module load cmake/3.15.7
module load git/2.17.1
module load vim/8.1.2424
module load python3/3.6.8
source ~/.bashrc
conda activate query 
module list                      # list modules loaded by default
echo $(module list)              # list modules loaded
echo $(which gcc)
echo $(which python)
echo $(which python3)
nvidia-smi --format=csv --query-gpu=name,driver_version,power.limit
sleep 12h
echo "Job end at $(date "+%Y-%m-%d %H:%M:%S")"

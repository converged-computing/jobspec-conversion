#!/bin/bash
#SBATCH --output=nv_%j.out
#SBATCH --error=nv_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:teslaK80:2
#SBATCH --time=06:00:00
#SBATCH --partition=gpu

module load gcc/6.2.0
module load cuda/10.0
echo "#---------"
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
nvidia-smi |grep "|\    [$CUDA_VISIBLE_DEVICES] "|awk '{print $3}'|xargs -r ps -o pid,ppid,uid -p
echo "#----------"
~/nvida_samples/1_Utilities/deviceQuery/deviceQuery

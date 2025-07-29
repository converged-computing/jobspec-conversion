#!/bin/bash
#SBATCH --job-name=multigpu_cnn
#SBATCH --mail-user=id@umons.ac.be
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=5G
#SBATCH --time=01:00:00

module use "$HOME"/modulefiles/
module load python/3.8.6rc1
echo "DATE : $(date)"
echo "_____________________________________________"
echo " HOSTNAME             : $HOSTNAME"
echo "_____________________________________________"
echo " CUDA_DEVICE_ORDER    : $CUDA_DEVICE_ORDER"
echo "_____________________________________________"
echo " CUDA_VISIBLE_DEVICES : $CUDA_VISIBLE_DEVICES"
echo "_____________________________________________"
nvidia-smi -L
echo "_____________________________________________"
time python -V
du -sh ~/TUH_SZ_v1.5.2/TUH/
du -sh ~/CHBMIT/
free -h
lscpu

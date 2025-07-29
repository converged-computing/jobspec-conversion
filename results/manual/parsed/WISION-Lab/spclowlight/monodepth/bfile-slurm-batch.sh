#!/bin/bash
#SBATCH --job-name=monodepth
#SBATCH --output=slurm.%j.%N.out
#SBATCH --error=slurm.%j.%N.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=4-00:00:00
#SBATCH --exclude=euler50,euler54

module load anaconda/3
bootstrap_conda
conda activate minienv
which python
hostname
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
top -b -d1 -n1 | grep -i "%Cpu" #This will show cpu utilization at the start of the script
LOG_FILE=val.txt
python -u ../../../train.py --data-folder /nobackup/nyuv2/data_average10/  --evaluate models_19.pth.tar 2>&1 | tee $LOG_FILE 

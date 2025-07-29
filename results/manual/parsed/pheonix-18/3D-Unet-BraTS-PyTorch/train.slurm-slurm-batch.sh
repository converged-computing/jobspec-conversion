#!/bin/bash
#SBATCH --job-name=3DU
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:volta:1
#SBATCH --mem=6144M

echo "Slurm nodes: $SLURM_JOB_NODELIST"
NUM_GPUS=`echo $GPU_DEVICE_ORDINAL | tr ',' '\n' | wc -l`
echo "You were assigned $NUM_GPUS gpu(s)"
nvidia-smi
module load anaconda3
module list
source activate pytorch
python3 train.py
echo "Ending script..."%                            

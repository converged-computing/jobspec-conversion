#!/bin/bash
#SBATCH --account=als_g
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=4
#SBATCH --time=01:00:00
#SBATCH --qos=regular
#SBATCH --constraint=gpu

export SLURM_CPU_BIND='cores'

echo "Starting at: $(date)"
module load python
conda activate batteryNET
echo "In conda environment: $CONDA_DEFAULT_ENV"
nvidia-smi
export SLURM_CPU_BIND="cores"
python train.py 'setup_files/xsection-unet2d.json' --num_workers 32 --epochs 100
STACK=IM_298-1_240
python predict_2d.py 'setup_files/xsection-unet2d.json' --predict_stack $STACK
echo "Done at : $(date)"

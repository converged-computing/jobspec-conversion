#!/bin/bash
#SBATCH --account=als_g
#SBATCH --output=%x-%a.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=1
#SBATCH --time=00:10:00
#SBATCH --qos=regular
#SBATCH --constraint=gpu
#SBATCH --array=0-240:10%4

export SLURM_CPU_BIND='cores'

echo "Starting at: $(date)"
module load python
conda activate batteryNET
echo "In conda environment: $CONDA_DEFAULT_ENV"
nvidia-smi
export SLURM_CPU_BIND="cores"
STACK=IM_298-1_$(printf "%03d" $SLURM_ARRAY_TASK_ID)
python predict_2d.py setup_files/xsection-unet2d.json --predict_stack $STACK
echo "Done at : $(date)"

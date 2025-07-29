#!/bin/bash
#SBATCH --account=stud-ewi-crs-in4253et
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=8192
#SBATCH --time=01:00:00
#SBATCH --partition=stud-ewi
#SBATCH --qos=stud-ewi

module use /opt/insy/modulefiles
module load cuda/10.1 cudnn/10.1-7.6.0.64
srun python3 ./adv_model_script.py

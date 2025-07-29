#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=24000
#SBATCH --time=1-00:00:00

module purge
module load gcc/5.4.0 python-env/intelpython3.6-2018.3
module load openmpi/2.1.2 cuda/9.0 cudnn/7.4.1-cuda9
srun python gen_motion_data.py

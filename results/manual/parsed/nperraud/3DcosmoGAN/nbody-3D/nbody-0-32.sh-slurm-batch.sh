#!/bin/bash
#SBATCH --account=sd01
#SBATCH --output=nbody-32-%j.log
#SBATCH --error=nbody-32-e-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=23:59:00
#SBATCH --constraint=gpu

module load daint-gpu
module load cray-python
module load TensorFlow/1.12.0-CrayGNU-18.08-cuda-9.1-python3
source /users/nperraud/upgan/bin/activate
srun python nbody-0-32.py

#!/bin/bash
#SBATCH --account=sbel
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx2080ti:1
#SBATCH --time=3-00:00:00
#SBATCH --qos=sbel_owner

module load gcc/9.2.0
module load cmake/3.18.1
module load cuda/11.1
module load glfw/3.3.2
module load intel/mkl/2019_U2
module load openmpi/4.0.2
./demo_GPU_ballcosim demo_GPU_ballcosim.json

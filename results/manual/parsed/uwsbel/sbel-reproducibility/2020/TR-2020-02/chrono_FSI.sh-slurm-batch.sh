#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --time=10-00:00:00

module load gcc/7.3.0
module load cmake/3.15.4
module load cuda/10.1
../../chrono-dev-build-gauss/bin/demo_FSI_Rover_granular_NSC demo_FSI_Rover_granular.json

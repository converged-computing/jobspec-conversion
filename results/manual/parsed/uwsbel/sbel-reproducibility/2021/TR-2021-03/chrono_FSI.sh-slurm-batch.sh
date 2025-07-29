#!/bin/bash
#SBATCH --account=sbel
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --qos=sbel_owner

module load gcc/9.2.0
module load cmake/3.18.1
module load cuda/11.1
../../chrono-dev-build/bin/demo_FSI_Viper_granular_NSC demo_FSI_Viper_granular.json 1 0.5 1.0

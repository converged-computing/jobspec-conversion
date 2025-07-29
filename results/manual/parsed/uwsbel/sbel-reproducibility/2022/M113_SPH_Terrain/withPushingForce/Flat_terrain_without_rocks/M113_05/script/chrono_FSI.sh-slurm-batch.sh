#!/bin/bash
#SBATCH --output=./Slurm_Out/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=1-00:00:00
#SBATCH --partition=sbel

module load nvidia/cuda/11.3.1
mkdir ./DEMO_OUTPUT/FSI_M113/M113_05/script
cp demo_FSI_m113_granular.cpp \
demo_FSI_m113_granular_NSC.json \
M113_Simulation.txt \
chrono_FSI.sh \
CMakeLists.txt \
./DEMO_OUTPUT/FSI_M113/M113_05/script/
./demo_FSI_m113_granular ./demo_FSI_m113_granular_NSC.json

#!/bin/bash
#SBATCH --output=./Slurm_Out/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx2080ti:1
#SBATCH --time=1-00:00:00
#SBATCH --partition=sbel

module load nvidia/cuda/11.3.1
mkdir ./DEMO_OUTPUT/FSI_VIPER/Rover_rock_32/script
cp demo_ROBOT_Viper_SPH.cpp \
demo_FSI_Viper_granular_NSC.json \
VIPER_Rock_Simulation.txt \
chrono_FSI.sh \
CMakeLists.txt \
blade.obj \
plate.obj \
rock.obj \
rock1.obj \
rock2.obj \
rock3.obj \
./DEMO_OUTPUT/FSI_VIPER/Rover_rock_32/script/
./demo_ROBOT_Viper_SPH ./demo_FSI_Viper_granular_NSC.json

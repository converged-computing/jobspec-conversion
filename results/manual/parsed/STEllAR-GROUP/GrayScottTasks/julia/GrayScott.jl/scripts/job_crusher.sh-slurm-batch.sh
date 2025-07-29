#!/bin/bash
#SBATCH --job-name=gs-julia-1MPI-1GPU
#SBATCH --account=CSC383_crusher
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:02:00

date
GS_DIR=/lustre/orion/proj-shared/csc383/wgodoy/GrayScott.jl
GS_EXE=$GS_DIR/gray-scott.jl
srun -n 1 --gpus=1 julia --project=$GS_DIR $GS_EXE settings-files.json

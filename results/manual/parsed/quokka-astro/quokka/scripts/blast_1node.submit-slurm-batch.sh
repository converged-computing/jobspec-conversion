#!/bin/bash
#SBATCH --job-name=hydro3dblast
#SBATCH --account=cvz-delta-gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gpus-per-task=1
#SBATCH --mem=0
#SBATCH --time=00:10:00
#SBATCH --exclusive
#SBATCH --constraint=scratch,ntasks-per-node=4

module purge
module load gcc/11.2.0
module load cuda/11.7.0
module load openmpi/4.1.4
EXE="./build/src/HydroBlast3D/test_hydro3d_blast"
INPUTS="tests/blast_unigrid_256.in max_timesteps=1000"
GPU_AWARE_MPI=""
nvidia-smi topo -m
srun bash -c "
    export CUDA_VISIBLE_DEVICES=\$((3-SLURM_LOCALID));
    ${EXE} ${INPUTS} ${GPU_AWARE_MPI}"

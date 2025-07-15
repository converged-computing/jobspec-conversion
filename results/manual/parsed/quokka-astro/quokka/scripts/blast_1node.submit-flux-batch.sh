#!/bin/bash
#FLUX: --job-name="hydro3dblast"
#FLUX: -c=16
#FLUX: --gpus-per-task=1
#FLUX: --exclusive
#FLUX: --queue=gpuA100x4
#FLUX: -t=600
#FLUX: --priority=16

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

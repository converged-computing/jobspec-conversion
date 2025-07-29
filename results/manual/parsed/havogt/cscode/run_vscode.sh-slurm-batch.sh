#!/bin/bash
#SBATCH --job-name=vscode
#SBATCH --account=csstaff
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=gpu

export CRAY_CUDA_MPS='1'
export HV_WORKSPACE='$SCRATCH/gt4py_vscode_workspace # TODO make unique'

export CRAY_CUDA_MPS=1
module load daint-gpu
module load sarus
export HV_WORKSPACE=$SCRATCH/gt4py_vscode_workspace # TODO make unique
rm -rf $HV_WORKSPACE
git clone https://github.com/GridTools/gt4py.git $HV_WORKSPACE
srun sarus run --mount=type=bind,source=$HV_WORKSPACE,destination=/workspace --init gitpod/openvscode-server 

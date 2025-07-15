#!/bin/bash
#FLUX: --job-name="vscode"
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --priority=16

export CRAY_CUDA_MPS='1'
export HV_WORKSPACE='$SCRATCH/gt4py_vscode_workspace # TODO make unique'

export CRAY_CUDA_MPS=1
module load daint-gpu
module load sarus
export HV_WORKSPACE=$SCRATCH/gt4py_vscode_workspace # TODO make unique
rm -rf $HV_WORKSPACE
git clone https://github.com/GridTools/gt4py.git $HV_WORKSPACE
srun sarus run --mount=type=bind,source=$HV_WORKSPACE,destination=/workspace --init gitpod/openvscode-server 

#!/bin/bash
#FLUX: --job-name=hairy-lettuce-3917
#FLUX: --priority=16

date
GS_DIR=/lustre/orion/proj-shared/csc383/wgodoy/GrayScott.jl
GS_EXE=$GS_DIR/gray-scott.jl
srun -n 1 --gpus=1 julia --project=$GS_DIR $GS_EXE settings-files.json

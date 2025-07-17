#!/bin/bash
#FLUX: --job-name=gs-julia-1MPI-1GPU
#FLUX: --queue=batch
#FLUX: -t=120
#FLUX: --urgency=16

date
GS_DIR=/gpfs/alpine/proj-shared/csc383/wgodoy/ADIOS2/examples/simulations/GrayScott.jl
GS_EXE=$GS_DIR/gray-scott.jl
srun -n 1 --gpus=1 julia --project=$GS_DIR $GS_EXE settings-files.json

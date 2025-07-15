#!/bin/bash
#FLUX: --job-name=dinosaur-bicycle-3390
#FLUX: --queue=sbel
#FLUX: -t=86400
#FLUX: --priority=16

module load nvidia/cuda/11.3.1
mkdir ./DEMO_OUTPUT/FSI_M113/M113_05/script
cp demo_FSI_m113_granular.cpp \
demo_FSI_m113_granular_NSC.json \
M113_Simulation.txt \
chrono_FSI.sh \
CMakeLists.txt \
./DEMO_OUTPUT/FSI_M113/M113_05/script/
./demo_FSI_m113_granular ./demo_FSI_m113_granular_NSC.json

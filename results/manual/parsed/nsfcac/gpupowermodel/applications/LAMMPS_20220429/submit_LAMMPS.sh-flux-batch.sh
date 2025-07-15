#!/bin/bash
#FLUX: --job-name=LAMMPS_A100_DATA
#FLUX: --queue=toreador
#FLUX: -t=36000
#FLUX: --priority=16

module load gcc cuda
./build_LAMMPS_NGC.sh # build Singularity container and do a test run
./clean # remove any results from prior runs and create a results folder
./launch

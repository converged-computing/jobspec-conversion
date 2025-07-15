#!/bin/bash
#FLUX: --job-name=step-7
#FLUX: --queue=gpu-geforce
#FLUX: --priority=16

/home/yfwang09/Codes/lammps/src/lmp_icc_serial -sf gpu -pk gpu 1 -in /home/yfwang09/Codes/MLmat/MetallicGlass/data/natom-5000/qrate-1.0e+10/sample_0/lammps_scripts/in.7
wait

#!/bin/bash
#FLUX: --job-name=step-4.0u_0.2660-0
#FLUX: --queue=gpu-geforce
#FLUX: --urgency=16

/home/yfwang09/Codes/lammps/src/lmp_icc_serial -sf gpu -pk gpu 1 -in /home/yfwang09/Codes/MLmat/MetallicGlass/data/natom-5000/qrate-2.8e+07/sample_0/erate-1.0e+07/strain_0-4.0/T2K/lammps_scripts/in.4.0u_0.2660-0
wait

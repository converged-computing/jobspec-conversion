#!/bin/bash
#FLUX: --job-name=stanky-fudge-3102
#FLUX: -t=86400
#FLUX: --urgency=16

mpirun lmp -var configfile ../Inputs/n360/kalj_n360_create.lmp -var id 1 -in ../Inputs/create_3d_binary.lmp
mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T1.5.lmp -var id 1 -in ../Inputs/production_3d_binary.lmp
mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T1.0.lmp -var id 1 -in ../Inputs/production_3d_binary.lmp
mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T0.9.lmp -var id 1 -in ../Inputs/production_3d_binary.lmp
mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T0.8.lmp -var id 1 -in ../Inputs/production_3d_binary.lmp
mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T0.7.lmp -var id 1 -in ../Inputs/production_3d_binary.lmp
mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T0.65.lmp -var id 1 -in ../Inputs/production_3d_binary.lmp
mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T0.6.lmp -var id 1 -in ../Inputs/production_3d_binary.lmp
mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T0.55.lmp -var id 1 -in ../Inputs/production_3d_binary.lmp
mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T0.5.lmp -var id 1 -in ../Inputs/production_3d_binary.lmp
mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T0.475.lmp -var id 1 -in ../Inputs/production_3d_binary.lmp
mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T0.45.lmp -var id 1 -in ../Inputs/production_3d_binary.lmp

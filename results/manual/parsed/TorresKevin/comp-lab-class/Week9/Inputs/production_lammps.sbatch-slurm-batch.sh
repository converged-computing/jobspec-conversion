#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=4

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

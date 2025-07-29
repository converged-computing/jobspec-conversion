#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=8-08:00:00
#SBATCH --qos=gpu-huge
#SBATCH --constraint=ntasks-per-node=4

/storage/liushiLab/huyihao/DPMD/Version2.0.1/bin/lmp -in input_npt.lammps > lmp.log

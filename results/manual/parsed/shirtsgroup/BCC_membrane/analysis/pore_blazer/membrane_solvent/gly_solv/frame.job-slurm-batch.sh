#!/bin/bash
#SBATCH --output=%x.out
#SBATCH --mail-user=nasc4134@colorado.edu
#SBATCH --mail-type=NONE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

module load gcc
module load cuda/11.1.1
module load openmpi/3.1.6-gcc8.3.1
PATH=$PATH:/jet/home/schwinns/pkgs/gromacs/2020.5
source /jet/home/schwinns/pkgs/gromacs/2020.5/bin/GMXRC
source /jet/home/schwinns/.bashrc

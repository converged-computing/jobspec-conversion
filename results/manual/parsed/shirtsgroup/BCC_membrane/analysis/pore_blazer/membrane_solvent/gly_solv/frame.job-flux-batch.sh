#!/bin/bash
#FLUX: --job-name=fuzzy-hope-6015
#FLUX: --urgency=16

module load gcc
module load cuda/11.1.1
module load openmpi/3.1.6-gcc8.3.1
PATH=$PATH:/jet/home/schwinns/pkgs/gromacs/2020.5
source /jet/home/schwinns/pkgs/gromacs/2020.5/bin/GMXRC
source /jet/home/schwinns/.bashrc

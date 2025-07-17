#!/bin/bash
#FLUX: --job-name=crunchy-train-1945
#FLUX: --queue=RM-shared
#FLUX: -t=14400
#FLUX: --urgency=16

module load gcc
module load cuda/11.1.1
module load openmpi/3.1.6-gcc8.3.1
PATH=$PATH:/jet/home/schwinns/pkgs/gromacs/2020.5
source /jet/home/schwinns/pkgs/gromacs/2020.5/bin/GMXRC
source /jet/home/schwinns/.bashrc

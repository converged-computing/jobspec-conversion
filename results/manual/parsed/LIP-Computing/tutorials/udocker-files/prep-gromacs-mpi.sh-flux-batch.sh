#!/bin/bash
#FLUX: --job-name=prep_gromacs
#FLUX: --queue=hpc
#FLUX: --priority=16

export TUT_DIR='$HOME/udocker-tutorial'
export PATH='$HOME/udocker-1.3.10/udocker:$PATH'
export UDOCKER_DIR='$TUT_DIR/.udocker'

export TUT_DIR=$HOME/udocker-tutorial
export PATH=$HOME/udocker-1.3.10/udocker:$PATH
cd $TUT_DIR
export UDOCKER_DIR=$TUT_DIR/.udocker
module load python
echo "###############################"
hostname
echo ">> udocker command"
which udocker
echo
echo ">> List images"
udocker images
echo
echo ">> Create container"
udocker create --name=grom_mpi gromacs-mpi
echo
echo ">> Set execmode to F3"
udocker setup --execmode=F3 grom_mpi
echo
echo ">> List containers"
udocker ps -m -p

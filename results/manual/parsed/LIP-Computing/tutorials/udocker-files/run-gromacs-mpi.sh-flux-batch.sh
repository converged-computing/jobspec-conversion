#!/bin/bash
#FLUX: --job-name=run_gromacs_mpi
#FLUX: -N=2
#FLUX: -n=16
#FLUX: --queue=hpc
#FLUX: --priority=16

export TUT_DIR='$HOME/udocker-tutorial'
export PATH='$HOME/udocker-1.3.10/udocker:$PATH'
export UDOCKER_DIR='$TUT_DIR/.udocker'
export OUT_NAME='output/ud-tutorial'
export TRR='${OUT_NAME}.trr'
export XTC='${OUT_NAME}.xtc'
export EDR='${OUT_NAME}.edr'
export LOG='${OUT_NAME}.log'

export TUT_DIR=$HOME/udocker-tutorial
export PATH=$HOME/udocker-1.3.10/udocker:$PATH
export UDOCKER_DIR=$TUT_DIR/.udocker
export OUT_NAME=output/ud-tutorial
export TRR=${OUT_NAME}.trr
export XTC=${OUT_NAME}.xtc
export EDR=${OUT_NAME}.edr
export LOG=${OUT_NAME}.log
module load python/3.10.13
module load gcc11/openmpi/4.1.4
cd $TUT_DIR
module list
echo "###############################"
srun --mpi=pmi2 udocker run -v=$TUT_DIR/gromacs:/home/user -w=/home/user grom_mpi \
    gmx_mpi mdrun -s /home/user/input/md.tpr -e $EDR -x $XTC -o $TRR -g $LOG \
    -maxh 0.50 -resethway -noconfout -nsteps 10000

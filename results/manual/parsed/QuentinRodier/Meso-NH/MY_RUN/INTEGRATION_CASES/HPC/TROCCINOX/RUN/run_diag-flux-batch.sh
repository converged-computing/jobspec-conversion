#!/bin/bash
#FLUX: --job-name=rainbow-lizard-7236
#FLUX: --priority=16

export MPIRUN='Mpirun -np 1'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
export MPIRUN="Mpirun -np 1"
set -x
set -e
ln -sf $MESONH/PGD/rttov87_rtcoef.tar .
tar -xvf rttov87_rtcoef.tar
ls -lrt
rm -f TROCC.1.CEN4T.008dg.???
time ${MPIRUN} DIAG${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_diag
mv OUTPUT_LISTING1  OUTPUT_LISTING1_diag
rm -f file_for_xtransfer pipe_name
ls -lrt
rm -f rttov87_rtcoef.tar *.dat
ja
cd ../PYTHON
sbatch run_python

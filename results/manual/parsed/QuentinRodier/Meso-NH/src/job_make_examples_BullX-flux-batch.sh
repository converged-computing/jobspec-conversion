#!/bin/bash
#FLUX: --job-name=Examples
#FLUX: -t=3600
#FLUX: --urgency=16

export MONORUN='Mpirun -np 1 '
export MPIRUN='Mpirun -np 2 '
export POSTRUN='time '

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
unset MAKEFLAGS
. ../conf/profile_mesonh-LXifort-R8I4-MNH-V5-7-0-MPIINTEL-O3
export MONORUN="Mpirun -np 1 "
export MPIRUN="Mpirun -np 2 "
export POSTRUN="time "
cd $SRC_MESONH/MY_RUN/KTEST/003_KW78 
make -k
echo "#################################################################################"
echo "##CAS SUIVANT####################################################################"
echo "#################################################################################"
cd $SRC_MESONH/MY_RUN/KTEST/001_2Drelief 
make -k
echo "#################################################################################"
echo "##CAS SUIVANT####################################################################"
echo "#################################################################################"
cd $SRC_MESONH/MY_RUN/KTEST/002_3Drelief 
make -k
echo "#################################################################################"
echo "##CAS SUIVANT####################################################################"
echo "#################################################################################"
cd $SRC_MESONH/MY_RUN/KTEST/004_Reunion
make -k << EOF 
EOF
echo "#################################################################################"
echo "##CAS SUIVANT####################################################################"
echo "#################################################################################"
cd $SRC_MESONH/MY_RUN/KTEST/007_16janvier
make -k << EOF 
EOF

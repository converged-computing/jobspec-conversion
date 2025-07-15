#!/bin/bash
#FLUX: --job-name=boopy-egg-9092
#FLUX: --priority=16

export MONORUN='Mpirun -np 1 '
export MPIRUN='Mpirun -np 2 '
export POSTRUN='echo '
export MNH_PYTHON='NO'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
unset MAKEFLAGS
. ../conf/profile_mesonh-LXifort-R8I4-MNH-V5-7-0-MPIAUTO-O2
export MONORUN="Mpirun -np 1 "
export MPIRUN="Mpirun -np 2 "
export POSTRUN="echo "
export MNH_PYTHON="NO"
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
module purge
module load python/3.7.6
cd $SRC_MESONH/MY_RUN/KTEST/003_KW78 
make python
cd $SRC_MESONH/MY_RUN/KTEST/001_2Drelief 
make python
cd $SRC_MESONH/MY_RUN/KTEST/002_3Drelief 
make python
cd $SRC_MESONH/MY_RUN/KTEST/004_Reunion
make python
cd $SRC_MESONH/MY_RUN/KTEST/007_16janvier
make python
module purge

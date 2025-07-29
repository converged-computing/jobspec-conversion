#!/bin/bash
#SBATCH --job-name=Examples
#SBATCH --output=Examples.eo%j
#SBATCH --error=Examples.eo%j
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --exclusive
#SBATCH --constraint=BDW28

export MONORUN='Mpirun -prepend-rank -np 1 '
export MPIRUN='Mpirun -prepend-rank -np 4 '
export POSTRUN='echo '

ulimit -c 0
ulimit -s unlimited
set -x
hostname 
unset MAKEFLAGS
. ../conf/profile_mesonh-LXifort-R8I4-MNH-V5-7-0-MPIINTEL-O2
export MONORUN="Mpirun -prepend-rank -np 1 "
export MPIRUN="Mpirun -prepend-rank -np 4 "
export POSTRUN="echo "
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
echo "#################################################################################"
echo "##CAS SUIVANT####################################################################"
echo "#################################################################################"
cd $SRC_MESONH/MY_RUN/KTEST/014_LIMA 
make -k

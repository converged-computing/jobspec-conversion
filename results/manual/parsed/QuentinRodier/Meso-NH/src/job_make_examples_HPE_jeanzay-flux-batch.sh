#!/bin/bash
#FLUX: --job-name=Examples
#FLUX: -N=2
#FLUX: -n=4
#FLUX: --exclusive
#FLUX: --queue=qos_cpu-dev
#FLUX: -t=3600
#FLUX: --urgency=16

export MONORUN='Exec srun -l -n 1 --export=ALL numabind_core_slurm'
export MPIRUN='Exec srun -l -n 4 --export=ALL numabind_core_slurm'
export POSTRUN='echo '

ulimit -c 0
ulimit -s unlimited
set -x
hostname 
unset MAKEFLAGS
. ../conf/profile_mesonh-LXifort-R8I4-MNH-V5-7-0-MPIINTEL-O2
export MONORUN="Exec srun -l -n 1 --export=ALL numabind_core_slurm"
export MPIRUN="Exec srun -l -n 4 --export=ALL numabind_core_slurm"
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

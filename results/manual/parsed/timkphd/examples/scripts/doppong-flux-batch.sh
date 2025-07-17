#!/bin/bash
#FLUX: --job-name=ppong
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=debug
#FLUX: -t=600
#FLUX: --urgency=16

export TPN='$SLURM_CPUS_ON_NODE'
export OMP_NUM_THREADS='1'
export EXE='ppong.intel'

mkdir $SLURM_JOB_ID
cd $SLURM_JOB_ID
export TPN=$SLURM_CPUS_ON_NODE
ulimit -s unlimited
export OMP_NUM_THREADS=1
cat $0 > script
wget https://raw.githubusercontent.com/timkphd/examples/master/hello_bgq/ppong.c
wget https://raw.githubusercontent.com/timkphd/examples/master/hello_bgq/todo.py
chmod 755 todo.py
if [[ $SLURM_CLUSTER_NAME == "vermilion" ]] ; then
  if [ -z "$UCX_TLS" ] ; then
    export UCX_TLS=sm,tcp
  fi
  if [[ UCX_TLS == "none" ]] ; then
    unset UCX_TLS
  fi
fi
printenv > env
./todo.py
module purge
if [[ $SLURM_CLUSTER_NAME == "vermilion" ]] ; then
  ml openmpi gcc
  ml ucx/1.11.1-zhbejzy
fi
if [[ $SLURM_CLUSTER_NAME == "eagle" ]] ; then
  ml openmpi/4.1.0/gcc-8.4.0
  ml gcc/8.4.0
fi
if [[ $SLURM_CLUSTER_NAME == "swift" ]] ; then
  ml slurm/21-08-1-1-o2xw5ti
  ml openmpi/4.1.1-6vr2flz
  ml gcc/9.4.0-v7mri5d
fi
mpicc   ppong.c -lm -o ppong.ompi
export EXE=ppong.ompi
srun --mpi=pmi2 --tasks-per-node=$TPN   $EXE -F > out.ompi
module purge
if [[ $SLURM_CLUSTER_NAME == "vermilion" ]] ; then
  ml intel-oneapi-compilers
  ml intel-oneapi-mpi
  ml intel-oneapi-mkl
  ml gcc
  ml ucx/1.11.1-zhbejzy
fi
if [[ $SLURM_CLUSTER_NAME == "eagle" ]] ; then
  ml intel-mpi/2020.1.217
  ml comp-intel/2020.1.217
  ml gcc/10.1.0
fi
if [[ $SLURM_CLUSTER_NAME == "swift" ]] ; then
  ml slurm/21-08-1-1-o2xw5ti
  ml gcc/9.4.0-v7mri5d
  ml intel-oneapi-mpi/2021.3.0-hcp2lkf
  ml intel-oneapi-compilers/2021.3.0-piz2usr
fi
mpiicc  ppong.c -lm -o ppong.intel
export EXE=ppong.intel
srun --mpi=pmi2 --tasks-per-node=$TPN   $EXE -F > out.intel
cp ../slurm-$SLURM_JOB_ID* .

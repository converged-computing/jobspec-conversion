#!/bin/bash
#FLUX: --job-name=evasive-chip-6460
#FLUX: -N=2
#FLUX: --queue=cluster
#FLUX: -t=900
#FLUX: --urgency=16

export MITGCM='$HOME/github/MPI-Singularity-PoC/MITgcm_container/MITgcm'
export EXPDIR='$PWD/test2'
export MPI_HOME='/gxfs_work1/gxfs_home_interim/sw/spack/spack0.16.0/usr/opt/spack/linux-rhel8-x86_64/gcc-10.2.0/openmpi-3.1.6-vq6nij2zpkbenfwan5ku3wx6v6ekgguv'
export MPI_INC_DIR='/gxfs_work1/gxfs_home_interim/sw/spack/spack0.16.0/usr/opt/spack/linux-rhel8-x86_64/gcc-10.2.0/openmpi-3.1.6-vq6nij2zpkbenfwan5ku3wx6v6ekgguv/include'

export MITGCM=$HOME/github/MPI-Singularity-PoC/MITgcm_container/MITgcm
export EXPDIR=$PWD/test2
cp -r $MITGCM/verification/exp2 $EXPDIR
cp $EXPDIR/code/SIZE.h_mpi $EXPDIR/code/SIZE.h
module load openmpi/3.1.6
export MPI_HOME=/gxfs_work1/gxfs_home_interim/sw/spack/spack0.16.0/usr/opt/spack/linux-rhel8-x86_64/gcc-10.2.0/openmpi-3.1.6-vq6nij2zpkbenfwan5ku3wx6v6ekgguv
export MPI_INC_DIR=/gxfs_work1/gxfs_home_interim/sw/spack/spack0.16.0/usr/opt/spack/linux-rhel8-x86_64/gcc-10.2.0/openmpi-3.1.6-vq6nij2zpkbenfwan5ku3wx6v6ekgguv/include
bash compile.sh > compile.log 2>&1
bash prepare.sh
module list
cd $EXPDIR/run
mpirun -np 2 bash -c "hostname; ./mitgcmuv"
jobinfo

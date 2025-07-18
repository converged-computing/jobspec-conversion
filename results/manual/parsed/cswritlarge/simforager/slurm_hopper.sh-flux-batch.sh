#!/bin/bash
#FLUX: --job-name=simforagger-tutorial
#FLUX: -N=2
#FLUX: --queue=general
#FLUX: -t=172800
#FLUX: --urgency=16

export GASNET_MAX_SEGSIZE='128MB/P'
export UPCXX='/opt/spack/opt/spack/linux-rocky8-cascadelake/gcc-12.1.0/upcxx-2020.10.0-6eh2prmiaolqfqinq4wjbb5by6z2phw6/bin/upcxx'
export UPCXX_BIN='/opt/spack/opt/spack/linux-rocky8-cascadelake/gcc-12.1.0/upcxx-2020.10.0-6eh2prmiaolqfqinq4wjbb5by6z2phw6/bin'
export UPCXX_INC='/opt/spack/opt/spack/linux-rocky8-cascadelake/gcc-12.1.0/upcxx-2020.10.0-6eh2prmiaolqfqinq4wjbb5by6z2phw6/include'
export UPCXX_INSTALL='/opt/spack/opt/spack/linux-rocky8-cascadelake/gcc-12.1.0/upcxx-2020.10.0-6eh2prmiaolqfqinq4wjbb5by6z2phw6'
export UPCXX_LIB='/opt/spack/opt/spack/linux-rocky8-cascadelake/gcc-12.1.0/upcxx-2020.10.0-6eh2prmiaolqfqinq4wjbb5by6z2phw6/lib'
export UPCXX_ROOT='/opt/spack/opt/spack/linux-rocky8-cascadelake/gcc-12.1.0/upcxx-2020.10.0-6eh2prmiaolqfqinq4wjbb5by6z2phw6'
export UPCXX_SHARED_HEAP_SIZE='128 MB'
export UPCXX_THREADMODE='seq'
export UPCXX_CODEMODE='opt'
export UPCXX_NETWORK='ibv'

export GASNET_MAX_SEGSIZE=128MB/P
export UPCXX=/opt/spack/opt/spack/linux-rocky8-cascadelake/gcc-12.1.0/upcxx-2020.10.0-6eh2prmiaolqfqinq4wjbb5by6z2phw6/bin/upcxx
export UPCXX_BIN=/opt/spack/opt/spack/linux-rocky8-cascadelake/gcc-12.1.0/upcxx-2020.10.0-6eh2prmiaolqfqinq4wjbb5by6z2phw6/bin
export UPCXX_INC=/opt/spack/opt/spack/linux-rocky8-cascadelake/gcc-12.1.0/upcxx-2020.10.0-6eh2prmiaolqfqinq4wjbb5by6z2phw6/include
export UPCXX_INSTALL=/opt/spack/opt/spack/linux-rocky8-cascadelake/gcc-12.1.0/upcxx-2020.10.0-6eh2prmiaolqfqinq4wjbb5by6z2phw6
export UPCXX_LIB=/opt/spack/opt/spack/linux-rocky8-cascadelake/gcc-12.1.0/upcxx-2020.10.0-6eh2prmiaolqfqinq4wjbb5by6z2phw6/lib
export UPCXX_ROOT=/opt/spack/opt/spack/linux-rocky8-cascadelake/gcc-12.1.0/upcxx-2020.10.0-6eh2prmiaolqfqinq4wjbb5by6z2phw6
export UPCXX_SHARED_HEAP_SIZE='128 MB'
export UPCXX_THREADMODE=seq
export UPCXX_CODEMODE=opt
export UPCXX_NETWORK=ibv
module purge
module load gcc/12.1.0-crtl
module load cmake/3.11.4-qkyj
module load openmpi/4.1.3-j6zb
module load upcxx/2020.10.0-6eh2
srun --mpi=pmi2 install/bin/simforager --config simforager_null.config

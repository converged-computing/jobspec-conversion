#!/bin/bash
#FLUX: --job-name=ornery-fudge-1228
#FLUX: -n=8
#FLUX: --queue=rome16q
#FLUX: -t=240
#FLUX: --urgency=16

export OMPI_MCA_pml='^ucx'
export OMPI_MCA_btl_openib_if_include='mlx5_4:1'
export OMPI_MCA_btl_tcp_if_exclude='docker0,docker_gwbridge,eno1,eno2,lo,enp196s0f0np0,enp196s0f1np1,ib0,ib1,veth030713f,veth07ce296,veth50ead6f,veth73c0310,veth9e2a12b,veth9e2cc2e,vethecc4600,ibp65s0f1,enp129s0f0np0,enp129s0f1np1,ibp65s0f0'
export OMPI_MCA_btl_openib_allow_ib='1'
export OMPI_MCA_mpi_cuda_support='0'

ulimit -s 10240
module purge
module load slurm/21.08.8
module load gcc/10.2.0
module load openmpi/gcc/64/4.1.5
module load metis
export OMPI_MCA_pml="^ucx"
export OMPI_MCA_btl_openib_if_include="mlx5_4:1"
export OMPI_MCA_btl_tcp_if_exclude=docker0,docker_gwbridge,eno1,eno2,lo,enp196s0f0np0,enp196s0f1np1,ib0,ib1,veth030713f,veth07ce296,veth50ead6f,veth73c0310,veth9e2a12b,veth9e2cc2e,vethecc4600,ibp65s0f1,enp129s0f0np0,enp129s0f1np1,ibp65s0f0
export OMPI_MCA_btl_openib_allow_ib=1
export OMPI_MCA_mpi_cuda_support=0
mpirun -np $SLURM_NTASKS build/Debug/1b ~/UiB-INF339/matrices/delaunay_n24.mtx

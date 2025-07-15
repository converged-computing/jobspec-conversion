#!/bin/bash
#FLUX: --job-name=stinky-malarkey-3968
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: --priority=16

export OMPI_MCA_pml='^ucx'
export OMPI_MCA_btl_openib_if_include='mlx5_1:1'
export OMPI_MCA_btl_tcp_if_exclude='docker0,docker_gwbridge,eno1,eno2,lo,enp196s0f0np0,enp196s0f1np1,ib0,ib1,veth030713f,veth07ce296,veth50ead6f,veth73c0310,veth9e2a12b,veth9e2cc2e,vethecc4600,ibp65s0f1,enp129s0f0np0,enp129s0f1np1,ibp65s0f0'
export OMPI_MCA_btl_openib_allow_ib='1'
export OMPI_MCA_mpi_cuda_support='0'
export MV2_HOMOGENEOUS_CLUSTER='1'
export MV2_ENABLE_AFFINITY='0'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

ulimit -s 10240
module purge
module load slurm/21.08.8
module load libfabric/gcc/1.18.0
module load openmpi4/gcc/4.1.2
module load libevent/2.1.12-stable
module load cuda11.8/toolkit/11.8.0
module load metis
export OMPI_MCA_pml="^ucx"
export OMPI_MCA_btl_openib_if_include="mlx5_1:1"
export OMPI_MCA_btl_tcp_if_exclude=docker0,docker_gwbridge,eno1,eno2,lo,enp196s0f0np0,enp196s0f1np1,ib0,ib1,veth030713f,veth07ce296,veth50ead6f,veth73c0310,veth9e2a12b,veth9e2cc2e,vethecc4600,ibp65s0f1,enp129s0f0np0,enp129s0f1np1,ibp65s0f0
export OMPI_MCA_btl_openib_allow_ib=1
export OMPI_MCA_mpi_cuda_support=0
ldd /home/torel/bin/cpi-4.1.4.x86_64
export MV2_HOMOGENEOUS_CLUSTER=1
export MV2_ENABLE_AFFINITY=0
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
cd P3
make
for file in $(find /global/D1/projects/UiB-INF339/matrices/ | grep .mtx)
do
	echo $(basename $file)
	mpirun -np $SLURM_NTASKS --bind-to none ./main $file 1 2 4 8
done

#!/bin/bash
#FLUX: --job-name=hello-cat-8607
#FLUX: --priority=16

export IPUOF_CONFIG_PATH='/cm/shared/apps/graphcore/vipu/etc/ipuof.conf.d/p64_cl_a01_a16.conf'
export OMPI_MCA_opal_common_ucx_opal_mem_hooks='1'
export OMPI_MCA_pml_ucx_verbose='100'
export OMPI_MCA_btl_openib_warn_no_device_params_found='1'
export OMPI_MCA_btl_openib_allow_ib='1'
export OMPI_MCA_pml='^ucx'
export OMPI_MCA_btl_openib_if_include='mlx5_4:1'
export OMPI_MCA_btl='openib,self'
export OMPI_MCA_btl_tcp_if_exclude='lo,dis0,eno1,eno2,enp113s0f0,ib0,ib1,enp33s0f0,enp33s0f1'

ulimit -s 10240
mkdir -p ~/output/ipuq
module purge
source env.source
module load slurm/20.02.7
module load graphcore/vipu/1.16.1           # vipu-cli for IPUPOD64 m2000
module load graphcore/sdk/2.4.0             # Poplar 2.4.0
module load graphcore/tf/2.4.0_tf2.4.4      # Poplar 2.4.0  Tensorflow v2.4.4
export IPUOF_CONFIG_PATH=/cm/shared/apps/graphcore/vipu/etc/ipuof.conf.d/p64_cl_a01_a16.conf
module load numactl/gcc/2.0.13
export OMPI_MCA_opal_common_ucx_opal_mem_hooks=1
export OMPI_MCA_pml_ucx_verbose=100
export OMPI_MCA_btl_openib_warn_no_device_params_found=1
export OMPI_MCA_btl_openib_allow_ib=1
export OMPI_MCA_pml="^ucx"
export OMPI_MCA_btl_openib_if_include="mlx5_4:1"
export OMPI_MCA_btl=openib,self
export OMPI_MCA_btl_tcp_if_exclude=lo,dis0,eno1,eno2,enp113s0f0,ib0,ib1,enp33s0f0,enp33s0f1
mkdir -p ./bin/codelets
cp ./build/bin/codelets/algoipu.gp ./bin/codelets/algoipu.gp
cd ./build/
srun --mpi=pmi2 -n $SLURM_NTASKS --ntasks 1 -- \
	./pastis -i /global/D1/projects/ipumer/datasets/metaclust/metaclust50_500K.fasta -c 500000 --af sim_mat.mtx --ckthr 1 --absw

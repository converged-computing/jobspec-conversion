#!/bin/bash
#FLUX: --job-name=wobbly-banana-2872
#FLUX: -t=1200
#FLUX: --urgency=16

export NCCL_TOPO_FILE='/nccl/topo.xml'
export FI_PROVIDER='efa'
export NCCL_DEBUG='info'
export NCCL_BUFFSIZE='33554432'
export NCCL_DEBUG_SUBSYS='init,net,graph,env'
export NCCL_MIN_NCHANNELS='32'
export OPAL_PREFIX='/opt/amazon/openmpi'
export OMPI_MCA_btl='tcp,self'
export OMPI_MCA_pml='^cm'
export OMPI_MCA_btl_tcp_if_exclude='lo,docker0'
export PMIX_MCA_gds='^ds12'
export PMIX_MCA_btl='tcp,self'
export PMIX_MCA_pml='^cm'
export PMIX_MCA_btl_tcp_if_exclude='lo,docker0'

export NCCL_TOPO_FILE="/nccl/topo.xml"
export 
LD_LIBRARY_PATH="/opt/nccl/build/lib:/usr/local/cuda/lib64:/opt/amazon/efa/lib64:/opt/amazon/openmpi/lib:/opt/aws-ofi-nccl/lib:$LD_LIBRARY_PATH"
export FI_PROVIDER=efa
export NCCL_DEBUG=info
export NCCL_BUFFSIZE=33554432
export NCCL_DEBUG_SUBSYS=init,net,graph,env
export NCCL_MIN_NCHANNELS=32
export OPAL_PREFIX=/opt/amazon/openmpi
export OMPI_MCA_btl=tcp,self
export OMPI_MCA_pml=^cm
export OMPI_MCA_btl_tcp_if_exclude=lo,docker0
export PMIX_MCA_gds=^ds12
export PMIX_MCA_btl=tcp,self
export PMIX_MCA_pml=^cm
export PMIX_MCA_btl_tcp_if_exclude=lo,docker0
env | grep "SLURMD_NODENAME="
env | grep "SLURM_NODELIST="
module load openmpi
srun --mpi=pmix --nodes=2 --tasks-per-node=8 --container-image=../../nemo_megatron_training.sqsh \
     --container-mounts="$PWD:/nccl" \
     bash -c "
     /nccl/nccl-tests/build/all_reduce_perf -b 256M -e 8G -f 2 -c 1 -n 10"

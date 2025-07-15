#!/bin/bash
#FLUX: --job-name=gloopy-staircase-7027
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -t=60
#FLUX: --priority=16

export OMPI_MCA_btl_self_rndv_eager_limit='256'
export OMPI_MCA_btl_self_eager_limit='256'
export OMPI_MCA_btl_sm_eager_limit='256'
export OMPI_MCA_btl_vader_eager_limit='256'
export OMPI_MCA_btl_sm_max_send_size='256'
export OMPI_MCA_osc_rdma_buffer_size='256'
export SLURM_CPU_BIND='verbose'

export OMPI_MCA_btl_self_rndv_eager_limit=256
export OMPI_MCA_btl_self_eager_limit=256
export OMPI_MCA_btl_sm_eager_limit=256
export OMPI_MCA_btl_vader_eager_limit=256
export OMPI_MCA_btl_sm_max_send_size=256
export OMPI_MCA_osc_rdma_buffer_size=256
export SLURM_CPU_BIND=verbose
srun --mpi=pmix -N2 --ntasks-per-node=1 -n $SLURM_NTASKS ./deadlock

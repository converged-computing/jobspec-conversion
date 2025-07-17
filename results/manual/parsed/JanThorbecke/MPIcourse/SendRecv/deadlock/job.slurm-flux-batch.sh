#!/bin/bash
#FLUX: --job-name=deadlock
#FLUX: -N=2
#FLUX: -n=2
#FLUX: --queue=compute
#FLUX: -t=60
#FLUX: --urgency=16

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

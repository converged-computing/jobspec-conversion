#!/bin/bash
#SBATCH --job-name=deadlock
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:01:00

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

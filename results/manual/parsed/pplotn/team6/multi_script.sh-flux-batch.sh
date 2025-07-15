#!/bin/bash
#FLUX: --job-name=multi
#FLUX: -n=4
#FLUX: -c=4
#FLUX: -t=28800
#FLUX: --priority=16

export OMPI_MCA_btl_openib_warn_no_device_params_found='0'
export UCX_MEMTYPE_CACHE='n'
export UCX_TLS='tcp'

module load dl
module load intelpython3
module load tensorflow/2.2
module load horovod/0.20.3
module list
export OMPI_MCA_btl_openib_warn_no_device_params_found=0
export UCX_MEMTYPE_CACHE=n
export UCX_TLS=tcp
srun -u -n ${SLURM_NTASKS} -N ${SLURM_NNODES} -c ${SLURM_CPUS_PER_TASK} --cpu-bind=cores  python main_multi.py 

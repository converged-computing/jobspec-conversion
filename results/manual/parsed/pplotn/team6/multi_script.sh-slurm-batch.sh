#!/bin/bash
#SBATCH --job-name=multi
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:4
#SBATCH --mem-per-cpu=256G
#SBATCH --time=08:00:00
#SBATCH --constraint=v100

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

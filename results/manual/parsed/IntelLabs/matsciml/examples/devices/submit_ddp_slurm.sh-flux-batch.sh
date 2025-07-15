#!/bin/bash
#FLUX: --job-name=hello-dog-5766
#FLUX: --exclusive
#FLUX: --queue=pvc
#FLUX: --priority=16

export CCL_ZE_IPC_EXCHANGE='sockets'
export ZE_FLAT_DEVICE_HIERARCHY='FLAT'

module purge
module load default-dawn
module load intel-oneapi-compilers
module load intelpython-conda
module load intel-oneapi-mkl
module load intel-oneapi-mpi
module load intel-oneapi-ccl
conda activate matsciml
export CCL_ZE_IPC_EXCHANGE=sockets
export ZE_FLAT_DEVICE_HIERARCHY=FLAT
ulimit -n 60000
srun python xpu_ddp_slurm.py

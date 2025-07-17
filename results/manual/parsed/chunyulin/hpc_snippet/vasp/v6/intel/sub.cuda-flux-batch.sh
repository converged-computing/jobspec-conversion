#!/bin/bash
#FLUX: --job-name=goodbye-car-6890
#FLUX: -c=4
#FLUX: --urgency=16

export I_MPI_PMI_LIBRARY='/lib64/libpmi.so'
export I_MPI_OFI_PROVIDER='mlx'

module purge
module load intel/2020 nvidia/cuda/10.1
export I_MPI_PMI_LIBRARY=/lib64/libpmi.so
export I_MPI_OFI_PROVIDER=mlx
srun --cpu_bind=v,cores /home/p00lcy01/VASP/b_intel/bin/vasp_gpu
echo "== Wall time: ${SECONDS} secs"

#!/bin/bash
#FLUX: --job-name=dinosaur-avocado-1848
#FLUX: -c=2
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module purge
module load singularity
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
img=("spack_python_20.04_openblas-2022-06-02-cded0171328d.simg"\
     "spack_python_20.04_mkl-2022-06-02-ac0ca4acdb94.simg")
echo "Using ${img[${SLURM_ARRAY_TASK_ID}]} on ${HOSTNAME}."
singularity exec ${img[${SLURM_ARRAY_TASK_ID}]} /opt/view/bin/python3 gemm.py

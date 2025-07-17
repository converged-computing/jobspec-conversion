#!/bin/bash
#FLUX: --job-name=expensive-cat-9605
#FLUX: --queue=courses-gpu
#FLUX: -t=300
#FLUX: --urgency=16

export OMPI_MCA_opal_warn_on_missing_libcuda='0'

module purge
export OMPI_MCA_opal_warn_on_missing_libcuda=0
module load gcc/11.3.0 cmake/3.26.3 openmpi/4.1.5
time srun ../build/quicksort-distributed-gpu

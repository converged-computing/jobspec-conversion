#!/bin/bash
#FLUX: --job-name=test_main2
#FLUX: -N=8
#FLUX: -c=80
#FLUX: -t=1500
#FLUX: --urgency=16

export OMP_NUM_THREADS='80'
export FOR_COARRAY_NUM_IMAGES='8'

cd $SLURM_SUBMIT_DIR
source ../utilities/module_load_niagara_intel.sh
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export FOR_COARRAY_NUM_IMAGES=8
export OMP_NUM_THREADS=80
cd ../main/
./main.x

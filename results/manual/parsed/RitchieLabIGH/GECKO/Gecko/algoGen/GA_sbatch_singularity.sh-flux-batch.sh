#!/bin/bash
#FLUX: --job-name=doopy-puppy-9272
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_NTASKS'

module load compiler/gcc-5.3.0
module load mpi/openmpi-2.1.2
module load system/Python-3.6.3
export OMP_NUM_THREADS=$SLURM_NTASKS
echo $1 $2 $3
singularity exec -w --pwd /GECKO/ GECKO sh prod_client_script_C++_V3.sh $1  > $2  2>&1

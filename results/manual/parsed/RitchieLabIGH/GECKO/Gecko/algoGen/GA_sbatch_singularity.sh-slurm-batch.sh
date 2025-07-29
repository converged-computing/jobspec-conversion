#!/bin/bash
#SBATCH --output=GECKO_%j.out
#SBATCH --error=GECKO_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=90000

export OMP_NUM_THREADS='$SLURM_NTASKS'

module load compiler/gcc-5.3.0
module load mpi/openmpi-2.1.2
module load system/Python-3.6.3
export OMP_NUM_THREADS=$SLURM_NTASKS
echo $1 $2 $3
singularity exec -w --pwd /GECKO/ GECKO sh prod_client_script_C++_V3.sh $1  > $2  2>&1

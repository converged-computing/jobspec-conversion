#!/bin/bash
#SBATCH --job-name=test
#SBATCH --account=hck
#SBATCH --output=run.out
#SBATCH --error=run.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=05:00:00
#SBATCH --constraint=ntasks-per-node=1,gpu

export OMP_NUM_THREADS='4'

export OMP_NUM_THREADS=4
module load intel-oneapi/2022.1.0
module load daint-gpu/21.09
module load cudatoolkit/21.3_11.2
module swap gcc gcc/9.3.0
cd ./tests/3-localtemp/ ; srun -n $SLURM_NTASKS ../../bin/runKMC parameters.txt

#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:30:00
#SBATCH --partition=broadwl
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='28'

module load mpich/3.2
module load gcc/6.2
module load valgrind
export OMP_NUM_THREADS=28
CRX_MODEL=/project/jozik/midway2/repos/community-rx/model/Release/crx_model-0.3
$CRX_MODEL ./config.props

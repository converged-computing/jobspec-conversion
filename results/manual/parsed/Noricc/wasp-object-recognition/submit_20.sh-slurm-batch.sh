#!/bin/bash
#SBATCH --job-name=retrain
#SBATCH --account=computehpc
#SBATCH --output=retrain_%j.out
#SBATCH --error=retrain_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00

export OMP_SCHEDULE='static'
export OMP_PLACES='cores'
export OMP_PROC_BIND='CLOSE'

cat $0 # put the script in the output file
module purge
module load  GCC/7.3.0-2.30  CUDA/9.2.88  OpenMPI/3.1.1
module load Python/3.6.6
module list
ARGS=$@
export OMP_SCHEDULE=static
export OMP_PLACES=cores
export OMP_PROC_BIND=CLOSE
source venv/bin/activate
cd src
python retrain.py 25 1

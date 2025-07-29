#!/bin/bash
#SBATCH --account=<account_id>
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3GB
#SBATCH --time=00:20:00

module purge
module purge
module load conda
eval "$(conda shell.bash hook)"
conda activate hpc-python
srun --mpi=pmix_v2 python3 ../examples/write_final.py -n 1000

#!/bin/bash
#SBATCH --job-name=ll_mpi_numba_array
#SBATCH --account=PHYS030544
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5GB
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-10

echo 'running mpi test'
module load languages/miniconda
echo "Before activation: $(which python)"
source activate desktop_clone_env
echo "After activation: $(which python)"
size=$((SLURM_ARRAY_TASK_ID*75))
srun --mpi=pmi2 python LebwohlLasher_vector.py 50 $size 0.5 0

#!/bin/bash
#SBATCH --job-name=roughgen
#SBATCH --output=/scratch/pr63so/ga25cux2/roughgen/script_output.%j.out
#SBATCH --mail-user=johannes.klicpera@tum.de
#SBATCH --mail-type=END
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=13:00:00
#SBATCH --chdir=/scratch/pr63so/ga25cux2/

export OMP_NUM_THREADS='16'
export mpi_ranks='8'

source /etc/profile.d/modules.sh
module load python
export OMP_NUM_THREADS=16
export mpi_ranks=8
cd /home/hpc/pr63so/ga25cux2/roughgen
python -u ./parallel_gen.py
python -u ./start_sims.py

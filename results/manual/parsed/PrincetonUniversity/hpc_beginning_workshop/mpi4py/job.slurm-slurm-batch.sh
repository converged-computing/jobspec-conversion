#!/bin/bash
#SBATCH --job-name=mpi4py-test
#SBATCH --mail-user=<YourNetID>@princeton.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:01:00

module purge
module load anaconda3/2022.5 openmpi/gcc/<x.y.z>  # REPLACE <x.y.z>
conda activate fast-mpi4py
srun python hello_mpi.py

#!/bin/bash
#SBATCH --job-name=par_pari
#SBATCH --output=par_pari_%j.out
#SBATCH --error=par_pari_%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=400
#SBATCH --time=00:30:00

module load gcc/12.2.0-fasrc01  openmpi/4.1.4-fasrc01 pari/2.15.4-fasrc02
srun -n $SLURM_NTASKS --mpi=pmix gp < par_pari.gp

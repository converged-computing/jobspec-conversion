#!/bin/bash
#SBATCH --job-name=pbmpiORG1
#SBATCH --account=nn9404k
#SBATCH --output=slurm-%j.base
#SBATCH --nodes=1
#SBATCH --ntasks=61
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=25-00:00:00
#SBATCH --partition=long

STR="$(ls *.phy -x1)"
module load phylobayesmpi
mpirun -n 61 pb_mpi -d "$STR" -cat -gtr -dc "$STR".pb

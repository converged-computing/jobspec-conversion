#!/bin/bash
#SBATCH --job-name=search_3
#SBATCH --output=/global/home/users/pierrj/slurm_stdout/slurm-%j.out
#SBATCH --error=/global/home/users/pierrj/slurm_stderr/slurm-%j.out
#SBATCH --mail-user=pierrj@berkeley.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=20
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=3-00:00:00
#SBATCH --qos=savio_normal
#SBATCH --constraint=ntasks-per-node=1

module purge
module load gcc/7.4.0
module load openmpi
module load cmake
cd /global/scratch/users/pierrj/PAV_SV/PAV/raxml_ng_test
mpirun /global/scratch/users/pierrj/raxml_ng_savio1/bin/raxml-ng-mpi --msa savio1_T1.raxml.rba --prefix search_3 --threads 10 --extra thread-pin --seed 33333

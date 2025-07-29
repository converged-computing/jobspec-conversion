#!/bin/bash
#SBATCH --job-name=[*
#SBATCH --account=[*
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=standard
#SBATCH --qos=standard
#SBATCH: --exclusive

module load singularity
module load intel-mpi-19
cd $SLURM_SUBMIT_DIR
mpiexec singularity run [* YOUR SIF IMAGE NAME *] collective/osu_gather

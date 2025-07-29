#!/bin/bash
#SBATCH --job-name=lmp_ex1
#SBATCH --account=ta100
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=standard
#SBATCH --qos=short

export OMP_NUM_THREADS='1'

module load lammps/23_Jun_2022
export OMP_NUM_THREADS=1
srun lmp -i in.ethanol -l ${SLURM_NPROCS}_cpus.log.${SLURM_JOB_ID}

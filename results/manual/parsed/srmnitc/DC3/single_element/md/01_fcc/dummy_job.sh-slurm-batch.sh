#!/bin/bash
#SBATCH --job-name=fcc_VAR_Th
#SBATCH --account=sua183
#SBATCH --output=data/logs/job_out_VAR_Th.log
#SBATCH --error=data/logs/job_err_VAR_Th.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=shared
#SBATCH --constraint=ntasks-per-node=1

module --force purge
ml load cpu slurm gcc openmpi
lammps="${HOME}/dc3/lammps/src/lmp_mpi"
potdir="${HOME}/dc3/potentials"
date
srun  ${lammps} -in in.lmp \
                -log data/logs/lammps_VAR_Th.log \
                -screen none \
                -var potdir ${potdir} \
                -var RANDOM ${RANDOM} \
                -var Th VAR_Th
date

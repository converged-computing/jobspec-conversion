#!/bin/bash
#SBATCH --job-name=peierls
#SBATCH --output=lmp_peierls.out
#SBATCH --error=lmp_peierls.err
#SBATCH --mail-user=youremailaddress@yourinstitution.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1

cd ${SLURM_SUBMIT_DIR}
module load intel/2022a
echo "begin lammps"
echo "the job is ${SLURM_JOB_ID}"
rm -f strain-stress dump.*
mpirun ~/software/lammps-cms/src/lmp_mpi -in lmp_peierls.in
echo "lammps out"

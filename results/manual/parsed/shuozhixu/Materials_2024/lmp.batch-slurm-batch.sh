#!/bin/bash
#SBATCH --job-name=Ag
#SBATCH --output=Ag.out
#SBATCH --error=Ag.err
#SBATCH --mail-user=youremailaddress@yourinstitution.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --partition=cm3atou

cd ${SLURM_SUBMIT_DIR}
rm -f dump.* shear.*
module load intel/2022a
echo "begin lammps"
echo "the job is ${SLURM_JOB_ID}"
mpirun -np $SLURM_NPROCS ~/lammps-mbvo/mylammps/src/lmp_mpi -in lmp.in
echo "lammps out"

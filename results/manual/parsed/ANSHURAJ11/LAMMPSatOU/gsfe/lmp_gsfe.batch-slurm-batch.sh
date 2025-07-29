#!/bin/bash
#SBATCH --job-name=gsfe
#SBATCH --output=lmp_gsfe.out
#SBATCH --error=lmp_gsfe.err
#SBATCH --mail-user=youremailaddress@yourinstitution.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=4

cd ${SLURM_SUBMIT_DIR}
module load intel/2022a
echo "begin lammps"
echo "the job is ${SLURM_JOB_ID}"
rm -f gsfe gsfe_ori
mpirun ~/software/lammps-cms/src/lmp_mpi -in lmp_gsfe.in
echo "lammps out"

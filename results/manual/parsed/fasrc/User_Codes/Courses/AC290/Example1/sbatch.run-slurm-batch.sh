#!/bin/bash
#SBATCH --job-name=mpi_hello
#SBATCH --output=mpi_hello.out
#SBATCH --error=mpi_hello.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=00:00:30
#SBATCH --partition=shared

WORK_DIR=/scratch/${USER}/${SLURM_JOB_ID}
PRO=mpi_hello
mkdir -pv ${WORK_DIR}
cd $WORK_DIR
cp ${SLURM_SUBMIT_DIR}/${PRO}.x .
module load gcc/8.2.0-fasrc01 openmpi/3.1.1-fasrc01 
srun -n $SLURM_NTASKS --mpi=pmix ./${PRO}.x > ${PRO}.dat
cp *.dat ${SLURM_SUBMIT_DIR}
rm -rf ${WORK_DIR}

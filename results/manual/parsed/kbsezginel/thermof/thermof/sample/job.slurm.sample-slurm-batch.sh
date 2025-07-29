#!/bin/bash
#SBATCH --job-name=therMOF
#SBATCH --output=therMOF.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=12

export I_MPI_FABRICS_LIST='ofa'

echo JOB_ID: $SBATCH_JOBID JOB_NAME: $SBATCH_JOB_NAME
echo start_time: `date`
cd $SLURM_SUBMIT_DIR
module purge
module load intel/2017.1.132
module load intel-mpi/2017.1.132
module load lammps/stable_31Mar2017
export I_MPI_FABRICS_LIST="ofa"
srun --mpi=pmi2 lmp_mpi -in in.therMOF > lammps_out.txt
echo end_time: `date`
exit

#!/bin/bash
#SBATCH --job-name=hybrid
#SBATCH --output=logfile
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:20:00
#SBATCH --partition=scavenge

cd $SLURM_SUBMIT_DIR
module purge
echo "Job started on `hostname` at `date`"
echo "SLURM_JOBID="$SLURM_JOBID
ml intel/2018b LAMMPS/7Aug2019
srun lmp_mpi -nc -l my.log -var seed `echo $RANDOM` -i in.reaxc
echo "Job finished on `hostname` at `date`"

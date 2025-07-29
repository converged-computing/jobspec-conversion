#!/bin/bash
#SBATCH --job-name=ondemand/sys/myjobs/basic_lammps_parallel
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

scontrol show job $SLURM_JOB_ID
module load intel/19.0.5 mvapich2/2.3.4 lammps/3Mar20
cd $TMPDIR
sbcast -p /users/appl/srb/workshops/compchem/lammps/in.crack $TMPDIR/in.crack
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
srun --export=ALL -n 2 lammps < $TMPDIR/in.crack

#!/bin/bash
#FLUX: --job-name=faux-butter-1654
#FLUX: --priority=16

export PATH='$PATH:/home/snst/huysh20/.lammps_command'
export LAMMPS_POTENTIALS='/home/snst/huysh20/.lammps_command'

echo Time is `date`
echo Directory is $PWD
echo This job runs on the following nodes:
echo $SLURM_JOB_NODELIST
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu cores.
MPIRUN=mpirun #Intel mpi and Open MPI
MPIOPT=
module load lammps/3Mar20
export PATH=$PATH:/home/snst/huysh20/.lammps_command
export LAMMPS_POTENTIALS=/home/snst/huysh20/.lammps_command
$MPIRUN lmp_gpu_200303 -sf gpu -pk gpu 2 -in in.doubleHe.py
echo Time is `date`
echo Time is `date`
echo Directory is $PWD
echo This job runs on the following nodes:
echo $SLURM_JOB_NODELIST
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu cores.
MPIRUN=mpirun #Intel mpi and Open MPI
MPIOPT=
module load lammps/3Mar20
export PATH=$PATH:/home/snst/huysh20/.lammps_command
export LAMMPS_POTENTIALS=/home/snst/huysh20/.lammps_command
$MPIRUN lmp_gpu_200303 -sf gpu -pk gpu 2 -in in.doubleHe.py
echo Time is `date`

#!/bin/bash
#SBATCH --output=%x.e%j
#SBATCH --error=%x.e%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=7gb
#SBATCH --time=1-00:00:00
#SBATCH --partition=AMG

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK:-1}'
export LAMMPS_POTENTIALS='~/lammps/_res'

export OMP_NUM_THREADS="'${SLURM_CPUS_PER_TASK:-1}'"
echo 'JOB_NAME' $SLURM_JOB_NAME
echo 'JOB_ID' $SLURM_JOB_ID
echo 'JOB_CPUS_PER_NODE' $SLURM_JOB_CPUS_PER_NODE
echo 'CPUS_PER_TASK' $SLURM_CPUS_PER_TASK
echo 'OMP_NUM_THREADS' $OMP_NUM_THREADS$
hostname
date
module load Compiler/Intel/18u4 Q-Ch/LAMMPS/19Sep2019/intel/2018u4
export LAMMPS_POTENTIALS=~/lammps/_res
cd ~/lammps
mpirun -np ${SLURM_NTASKS} lammps -sf opt -pk omp ${OMP_NUM_THREADS} -in $SLURM_JOB_NAME.lam -log $SLURM_JOB_NAME.out >$SLURM_JOB_NAME.stdout
date
rm -f ~/$SLURM_JOB_NAME.e$SLURM_JOB_ID.err

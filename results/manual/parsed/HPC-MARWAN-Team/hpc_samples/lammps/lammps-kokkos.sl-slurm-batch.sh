#!/bin/bash
#SBATCH --job-name=lmp-demo
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --partition=defq
#SBATCH --constraint=ib

export WORK_DIR='/scratch/users/$USER/LMP${SLURM_JOB_ID}'
export INPUT_DIR='$PWD/input'

module load lammps-20210310-gcc-10.2.0-gd7o44k
scontrol  show jobid -dd ${SLURM_JOB_ID}
export WORK_DIR=/scratch/users/$USER/LMP${SLURM_JOB_ID}
export INPUT_DIR=$PWD/input
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR
echo "Running Lammps with  $SLURM_NTASKS  at : $WORK_DIR"
srun lmp -in myInput.in
echo "JOB Done"

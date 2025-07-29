#!/bin/bash
#FLUX: --job-name=lmp-demo
#FLUX: -n=4
#FLUX: --queue=defq
#FLUX: --urgency=16

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

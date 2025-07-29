#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:8
#SBATCH --time=1-00:00:00
#SBATCH --partition=GPU
#SBATCH --constraint=ntasks-per-node=40

set echo
set -x
module load namd/2.13-gpu
BASENAME=prod_ds1
cd $SLURM_SUBMIT_DIR
echo $SLURM_NTASKS
$BINDIR/namd2 +setcpuaffinity +p 40 +devices 0,1,2,3,4,5,6,7 ${BASENAME}.namd > ${BASENAME}.log

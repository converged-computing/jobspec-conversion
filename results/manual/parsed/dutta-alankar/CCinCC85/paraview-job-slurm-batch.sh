#!/bin/bash
#SBATCH --job-name=visualization
#SBATCH --output=%x-%j.log
#SBATCH --mail-user=alankardutta@iisc.ac.in
#SBATCH --mail-type=NONE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=5-20:00:00

export PROG='pvserver'

if [ X"$SLURM_STEP_ID" = "X" -a X"$SLURM_PROCID" = "X"0 ]
then
  echo "=========================================="
  echo "Date            = $(date)"
  echo "SLURM_JOB_ID    = $SLURM_JOB_ID"
  echo "Nodes Allocated = $SLURM_JOB_NUM_NODES"
  echo "=========================================="
fi
echo "Working Directory = $(pwd)"
cd $SLURM_SUBMIT_DIR
export PROG="pvserver"
module purge
module load paraview/5.11.0
srun $PROG

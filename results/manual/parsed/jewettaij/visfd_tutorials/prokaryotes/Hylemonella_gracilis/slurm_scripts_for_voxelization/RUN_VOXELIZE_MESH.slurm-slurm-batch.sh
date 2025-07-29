#!/bin/bash
#SBATCH --job-name=voxelize
#SBATCH --output=output.out
#SBATCH --error=output.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=32-00:00:00

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
time ~/bin/voxelize_mesh.py \
  -w 19.6 \
  -m membrane_inner.ply \
  -i orig_crop.rec \
  -o membrane_inner.rec
time ~/bin/voxelize_mesh.py \
  -w 19.6 \
  -m membrane_outer.ply \
  -i orig_crop.rec \
  -o membrane_outer.rec

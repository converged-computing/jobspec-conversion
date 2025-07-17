#!/bin/bash
#FLUX: --job-name=voxelize
#FLUX: -t=2764800
#FLUX: --urgency=16

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
time ~/bin/voxelize_mesh.py \
  -w 18.08 \
  -m membrane_inner.ply \
  -i orig_crop.rec \
  -o membrane_inner.rec
time ~/bin/voxelize_mesh.py \
  -w 18.08 \
  -m membrane_outer.ply \
  -i orig_crop.rec \
  -o membrane_outer.rec
time ~/bin/voxelize_mesh.py \
  -w 18.08 \
  -m membrane_host.ply \
  -i orig_crop.rec \
  -o membrane_host.rec

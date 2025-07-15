#!/bin/bash
#FLUX: --job-name=chunky-cat-5144
#FLUX: -c=4
#FLUX: -t=28800
#FLUX: --priority=16

if [ $HOSTNAME == "<your local machine name>" ]; then
  # for debug
  SLURM_ARRAY_TASK_ID=0
  # test : 6c641082-044e-46a7-ad5f-85568119e09e
  python colmap_utils/get_camera_poses_colmap.py --taskid $SLURM_ARRAY_TASK_ID \
    --input_dir data/clips_frames \
    --output_dir data/colmap_modesl
else
  # if on the cluster
  python colmap_utils/get_camera_poses_colmap.py \
   --taskid $SLURM_ARRAY_TASK_ID 
fi

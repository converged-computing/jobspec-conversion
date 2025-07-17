#!/bin/bash
#FLUX: --job-name=voxelize
#FLUX: --urgency=16

cd /rhome/ysiddiqui/sdf-gen
python process_meshes_matterport.py --mesh_dir /cluster/gondor/ysiddiqui/Matterport3DMeshes/ --df_lowres_dir /cluster/gondor/ysiddiqui/Matterport3DDistanceFields16/complete_lowres --df_highres_dir /cluster/gondor/ysiddiqui/Matterport3DDistanceFields16/complete_highres --chunk_lowres_dir /cluster/gondor/ysiddiqui/Matterport3DDistanceFields16/chunk_lowres --chunk_highres_dir /cluster/gondor/ysiddiqui/Matterport3DDistanceFields16/chunk_highres --num_proc $SLURM_ARRAY_TASK_COUNT --proc $SLURM_ARRAY_TASK_ID

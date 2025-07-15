#!/bin/bash
#FLUX: --job-name=voxelize
#FLUX: --priority=16

cd /rhome/ysiddiqui/sdf-gen
python process_meshes.py --mesh_dir /cluster/gondor/ysiddiqui/3DFrontCeilingMeshes/ --df_lowres_dir /cluster/gondor/ysiddiqui/3DFrontCeilingDistanceFields/complete_lowres --df_highres_dir /cluster/gondor/ysiddiqui/3DFrontCeilingDistanceFields/complete_highres --df_if_dir /cluster/gondor/ysiddiqui/3DFrontCeilingDistanceFields/complete_semantics --chunk_lowres_dir /cluster/gondor/ysiddiqui/3DFrontCeilingDistanceFields/chunk_lowres --chunk_highres_dir /cluster/gondor/ysiddiqui/3DFrontCeilingDistanceFields/chunk_highres --chunk_if_dir /cluster/gondor/ysiddiqui/3DFrontCeilingDistanceFields/chunk_semantics --num_proc $SLURM_ARRAY_TASK_COUNT --proc $SLURM_ARRAY_TASK_ID

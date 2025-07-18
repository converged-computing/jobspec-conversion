#!/bin/bash
#FLUX: --job-name=eccentric-cinnamonbun-3435
#FLUX: -t=86400
#FLUX: --urgency=16

singularity exec --nv \
  --bind /proj/nlp4adas/users/$USER:/workspace \
  --bind /proj/nlp4adas/checkpoints:/checkpoints \
  --bind /proj/nlp4adas/features:/features \
  --bind /proj/nlp4adas/datasets/once:/my_data \
  --bind /proj/nlp4adas/users/$USER/lidar-clippin/SST/mmdet3d/ops/sst/sst_ops.py:/sst/mmdet3d/ops/sst/sst_ops.py \
  --bind /proj/nlp4adas/users/$USER/lidar-clippin/SST/mmdet3d/models/backbones/sst_v1.py:/sst/mmdet3d/models/backbones/sst_v1.py \
  --bind /proj/nlp4adas/users/$USER/lidar-clippin/SST/mmdet3d/models/backbones/sst_v2.py:/sst/mmdet3d/models/backbones/sst_v2.py \
  --bind /proj/nlp4adas/users/$USER/lidar-clippin/SST/mmdet3d/models/voxel_encoders/utils.py:/sst/mmdet3d/models/voxel_encoders/utils.py \
  --pwd /workspace/lidar-clippin/ \
  --env PYTHONPATH=/workspace/lidar-clippin/ \
  /proj/nlp4adas/containers/lidar-clippin.sif \
  jupyter notebook --notebook-dir=/workspace --ip 0.0.0.0 --no-browser --allow-root

#!/bin/bash
#FLUX: --job-name=wobbly-sundae-3194
#FLUX: -t=259200
#FLUX: --urgency=16

export MASTER_PORT='$RANDOM'

export MASTER_PORT=$RANDOM
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
  python3 -u train.py --data-dir=/my_data --checkpoint-save-dir=/checkpoints $@

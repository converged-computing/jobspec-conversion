#!/bin/bash
#FLUX: --job-name=placid-ricecake-0763
#FLUX: -c=8
#FLUX: --queue=ztest
#FLUX: -t=2400
#FLUX: --urgency=16

echo "Full Dataset Testing (DBSCAN + PointNet)"
mkdir -p /workspaces/$USER/training/logs/
echo ""
echo "This job was started as: python3 -u $@"
echo ""
time=$(date "+%Y-%m-%d %H:%M:%S")
singularity exec --nv --bind /workspaces/$USER:/workspace \
  --bind /staging/thesisradardetection:/RadarScenes \
  --pwd /workspace/thesisdlradardetection/ \
  --env PYTHONPATH=. \
  --cleanenv \
  --no-home \
  /workspaces/$USER/radar_detect.sif \
  python3 -u /workspace/thesisdlradardetection/PointNet/Pnet_pytorch/test_radar_semseg.py \
	  --batch_size 32 \
          --num_point 3097 \
	  --log_dir GPU_Jun29_23_jitter_noise\
	  --iou_thresh 0.3\
	  #--debug

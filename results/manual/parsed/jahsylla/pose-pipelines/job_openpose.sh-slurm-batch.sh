#!/bin/bash
#FLUX: --job-name=baseline
#FLUX: -t=3600
#FLUX: --urgency=16

VIDEO=${1:-'~/pose-pipelines/example.mp4'}
OUTPUT=${2:-'~/pose-pipelines/example.openpose/'}
module load t4
module load singularityce
module load cudnn/7.6.5.32-10.2
srun singularity exec \
-B /data -B /scratch \
-B /net/cephfs/data \
-B /net/cephfs/scratch \
--nv \
--pwd /openpose/ \
~/data/openpose_latest \
./build/examples/openpose/openpose.bin --video $VIDEO --write_json $OUTPUT --display 0 --face --hand --render_pose 0

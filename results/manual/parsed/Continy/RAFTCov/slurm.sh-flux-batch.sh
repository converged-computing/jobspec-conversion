#!/bin/bash
#FLUX: --job-name=StereoCov      # Job name
#FLUX: --priority=16

EXE=/bin/bash
singularity exec --nv --bind /data2/datasets/wenshanw/tartan_data:/zihao/datasets:ro,/data2/datasets/yuhengq/zihao/RAFTCov:/zihao/RAFTCov /data2/datasets/yuhengq/zihao/flowformer_v1.1.sif bash /zihao/RAFTCov/script.sh

#!/bin/bash
#FLUX: --job-name=stanky-truffle-7538
#FLUX: --queue=amdgpufast
#FLUX: -t=14400
#FLUX: --urgency=16

cd ../..
ml torchsparse/1.4.0-foss-2021a-CUDA-11.3.1
python evaluate_uda.py configs/data_config/da_wod_kitti/uda_wod_kitti.yaml --network student

#!/bin/bash
#FLUX --job-name=crusty-sundae-0989
#FLUX -c=24
#FLUX --queue=amdgpufast
#FLUX -t=14400
#FLUX --urgency=16

cd ../..
ml torchsparse/1.4.0-foss-2021a-CUDA-11.3.1
python evaluate_uda.py configs/data_config/da_wod_nuscenes/uda_nuscenes_wod.yaml --network Student

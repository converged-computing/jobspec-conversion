#!/bin/bash
#FLUX: --job-name=crusty-itch-2022
#FLUX: --priority=16

if [ "$#" -ne 2 ]; then
    echo "Please, provide the the training framework: torch/tf and dataset path"
    exit 1
fi
cd ../..
python scripts/run_pipeline.py $1 -c ml3d/configs/randlanet_s3dis.yml \
--dataset_path $2

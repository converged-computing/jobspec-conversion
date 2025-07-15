#!/bin/bash
#FLUX: --job-name=lovely-destiny-9195
#FLUX: --urgency=16

if [ "$#" -ne 2 ]; then
    echo "Please, provide the training framework: torch/tf and dataset path"
    exit 1
fi
cd ../..
python scripts/run_pipeline.py $1 -c ml3d/configs/randlanet_parislille3d.yml \
--dataset_path $2

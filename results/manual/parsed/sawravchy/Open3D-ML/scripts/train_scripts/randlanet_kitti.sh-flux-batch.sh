#!/bin/bash
#FLUX: --job-name=loopy-peanut-butter-6332
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: --urgency=16

if [ "$#" -ne 2 ]; then
    echo "Please, provide the the training framework: torch/tf and dataset path"
    exit 1
fi
cd ../..
python scripts/run_pipeline.py $1 -c ml3d/configs/randlanet_semantickitti.yml \
--dataset_path $2

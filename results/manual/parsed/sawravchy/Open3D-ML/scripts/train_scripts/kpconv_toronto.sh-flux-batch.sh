#!/bin/bash
#FLUX: --job-name=psycho-gato-3783
#FLUX: --urgency=16

if [ "$#" -ne 2 ]; then
    echo "Please, provide the the training framework: torch/tf and dataset path"
    exit 1
fi
cd ../..
python scripts/run_pipeline.py $1 -c ml3d/configs/kpconv_toronto3d.yml \
--dataset_path $2

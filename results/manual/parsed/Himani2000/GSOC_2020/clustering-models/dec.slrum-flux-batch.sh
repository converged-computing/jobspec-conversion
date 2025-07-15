#!/bin/bash
#FLUX: --job-name=dec model 
#FLUX: --queue=gpu
#FLUX: -t=79200
#FLUX: --urgency=16

module spider tensorflow/1.4.0-py3
module load intel/17 openmpi/2.0.1 
module load tensorflow/1.4.0-py3
python image_feature_extraction_with_pretrainedmodels.py  ideology_person_dataset  ideology_person_dataset_features
echo "completed job "

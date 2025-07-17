#!/bin/bash
#FLUX: --job-name=autoencoderfeatures 
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module spider tensorflow/1.4.0-py3
module load intel/17 openmpi/2.0.1 
module load tensorflow/1.4.0-py3
echo "running the autoencoder script"
python autoencoder_feature_extraction.py image_dataset image_features autoencoder_features image-dataset-name
python autoencoder_feature_extraction.py image_dataset image_features autoencoder_features_crop image-dataset-name

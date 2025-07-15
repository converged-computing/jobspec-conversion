#!/bin/bash
#FLUX: --job-name=cowy-leopard-8935
#FLUX: --queue=serial
#FLUX: --priority=16

SERVER_CONFIG=$1
module load anaconda/3-2021.11
module load cuda/10.1_cudnn-7.6.5
source activate NeilGAN_V2
if [ $SERVER_CONFIG == 0 ]
then
  srun python "gdown_download.py" --server_config=$SERVER_CONFIG
elif [ $SERVER_CONFIG == 5 ]
then
  python3 "gdown_download.py" --server_config=$SERVER_CONFIG
else
  python "gdown_download.py" --server_config=$SERVER_CONFIG
fi
if [ $SERVER_CONFIG == 0 ]
then
  OUTPUT_DIR="/scratch3/neil.delgallego/SynthWeather Dataset 10/"
elif [ $SERVER_CONFIG == 4 ]
then
  OUTPUT_DIR="D:/NeilDG/Datasets/SynthWeather Dataset 10/"
elif [ $SERVER_CONFIG == 5 ]
then
  OUTPUT_DIR="/home/neildelgallego/SynthWeather Dataset 10/"
else
  OUTPUT_DIR="/home/jupyter-neil.delgallego/SynthWeather Dataset 10/"
fi
DATASET_NAME="v90_istd"
echo "$OUTPUT_DIR/$DATASET_NAME.zip"
unzip -q "$OUTPUT_DIR/$DATASET_NAME.zip" -d "$OUTPUT_DIR"
DATASET_NAME="v91_istd"
echo "$OUTPUT_DIR/$DATASET_NAME.zip"
unzip -q "$OUTPUT_DIR/$DATASET_NAME.zip" -d "$OUTPUT_DIR"

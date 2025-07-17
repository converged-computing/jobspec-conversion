#!/bin/bash
#FLUX: --job-name=moolicious-lizard-8074
#FLUX: --queue=high
#FLUX: --urgency=16

source /etc/profile.d/lmod.sh
source /etc/profile.d/easybuild.sh
ml load NCCL/2.3.7-CUDA-9.0.176
module load socker
socker run mtg/carnatic_autoencoder python train.py full_dataset filelist_full_dataset.txt config_cqt.ini 
socker run mtg/carnatic_autoencoder python convert.py full_dataset filelist_full_dataset.txt config_cqt.ini 
socker run mtg/carnatic_autoencoder python convert.py full_dataset filelist_full_dataset.txt config_cqt.ini --self-sim-matrix 
socker run mtg/carnatic_autoencoder python extract_motives.py full_dataset -r 2 -th 0.01 -csv jku_csv_files.txt

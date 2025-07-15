#!/bin/bash
#FLUX: --job-name=___
#FLUX: -t=345600
#FLUX: --urgency=16

module load cudnn/7-cuda-10.0
 # python3 printing_the_files_name_in_the_directory.py
cd seeds_dataset
python download_images.py 

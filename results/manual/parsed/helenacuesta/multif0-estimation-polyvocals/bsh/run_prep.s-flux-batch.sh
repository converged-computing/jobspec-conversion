#!/bin/bash
#FLUX: --job-name=prep
#FLUX: -c=4
#FLUX: -t=180000
#FLUX: --priority=16

module purge
module load rubberband/intel/1.8.1
module load ffmpeg/intel/3.2.2
python 1_prep.py --audio-path /scratch/hc2945/data/audiomixtures --metadata-path /scratch/hc2945/data/audiomixtures/mtracks_info.json --save-dir /scratch/hc2945/data/features_targets

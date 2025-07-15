#!/bin/bash
#FLUX: --job-name=outstanding-car-7414
#FLUX: --urgency=16

python extract_annotations_interim.py --folder /home-3/pmahaja2@jhu.edu/scratch/vqa2018_data/
python extract_annotations_processed.py --dir /home-3/pmahaja2@jhu.edu/scratch/vqa2018_data/

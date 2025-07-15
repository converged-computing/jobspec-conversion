#!/bin/bash
#FLUX: --job-name=astute-sundae-4649
#FLUX: --priority=16

python extract_annotations_interim.py --folder /home-3/pmahaja2@jhu.edu/scratch/vqa2018_data/
python extract_annotations_processed.py --dir /home-3/pmahaja2@jhu.edu/scratch/vqa2018_data/

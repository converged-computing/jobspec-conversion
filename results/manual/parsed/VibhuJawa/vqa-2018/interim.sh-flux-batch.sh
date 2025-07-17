#!/bin/bash
#FLUX: --job-name=chocolate-avocado-0832
#FLUX: -n=2
#FLUX: --queue=shared
#FLUX: -t=1200
#FLUX: --urgency=16

python extract_annotations_interim.py --folder /home-3/pmahaja2@jhu.edu/scratch/vqa2018_data/
python extract_annotations_processed.py --dir /home-3/pmahaja2@jhu.edu/scratch/vqa2018_data/

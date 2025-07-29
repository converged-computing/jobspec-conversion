#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00

python extract_annotations_interim.py --folder /home-3/pmahaja2@jhu.edu/scratch/vqa2018_data/
python extract_annotations_processed.py --dir /home-3/pmahaja2@jhu.edu/scratch/vqa2018_data/

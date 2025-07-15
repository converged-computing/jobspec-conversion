#!/bin/bash
#FLUX: --job-name=faux-lizard-0781
#FLUX: -n=4
#FLUX: --queue=maxwell
#FLUX: -t=432000
#FLUX: --priority=16

setpkgs -a tensorflow_0.12
python  /scratch/yaoy4/BodySegmentation/run.py train
python  /scratch/yaoy4/BodySegmentation/run.py train
python  /scratch/yaoy4/BodySegmentation/run.py train
python  /scratch/yaoy4/BodySegmentation/run.py train
python  /scratch/yaoy4/BodySegmentation/run.py train
python  /scratch/yaoy4/BodySegmentation/run.py train
python  /scratch/yaoy4/BodySegmentation/run.py train

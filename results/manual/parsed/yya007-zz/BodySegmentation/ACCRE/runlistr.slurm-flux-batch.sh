#!/bin/bash
#FLUX: --job-name=salted-knife-8058
#FLUX: -n=4
#FLUX: --queue=maxwell
#FLUX: -t=432000
#FLUX: --urgency=16

setpkgs -a tensorflow_0.12
python  /scratch/yaoy4/BodySegmentation/run.py train random 
python  /scratch/yaoy4/BodySegmentation/run.py train random 
python  /scratch/yaoy4/BodySegmentation/run.py train random 
python  /scratch/yaoy4/BodySegmentation/run.py train random 
python  /scratch/yaoy4/BodySegmentation/run.py train random 
python  /scratch/yaoy4/BodySegmentation/run.py train random 
python  /scratch/yaoy4/BodySegmentation/run.py train random 

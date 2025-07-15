#!/bin/bash
#FLUX: --job-name=spicy-pastry-8707
#FLUX: -n=4
#FLUX: --queue=maxwell
#FLUX: -t=432000
#FLUX: --urgency=16

setpkgs -a tensorflow_0.12
python  /scratch/yaoy4/BodySegmentation/run.py train random 13
python  /scratch/yaoy4/BodySegmentation/run.py train random 13
python  /scratch/yaoy4/BodySegmentation/run.py train random 13
python  /scratch/yaoy4/BodySegmentation/run.py train random 13
python  /scratch/yaoy4/BodySegmentation/run.py train random 13
python  /scratch/yaoy4/BodySegmentation/run.py train random 13
python  /scratch/yaoy4/BodySegmentation/run.py train random 13

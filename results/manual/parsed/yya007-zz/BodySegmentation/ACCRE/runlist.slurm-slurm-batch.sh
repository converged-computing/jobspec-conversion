#!/bin/bash
#FLUX: --job-name=doopy-fork-8907
#FLUX: -n=4
#FLUX: --queue=maxwell
#FLUX: -t=432000
#FLUX: --urgency=16

setpkgs -a tensorflow_0.12
python  /scratch/yaoy4/BodySegmentation/run.py 
python  /scratch/yaoy4/BodySegmentation/run.py 
python  /scratch/yaoy4/BodySegmentation/run.py 
python  /scratch/yaoy4/BodySegmentation/run.py 
python  /scratch/yaoy4/BodySegmentation/run.py 
python  /scratch/yaoy4/BodySegmentation/run.py 
python  /scratch/yaoy4/BodySegmentation/run.py 

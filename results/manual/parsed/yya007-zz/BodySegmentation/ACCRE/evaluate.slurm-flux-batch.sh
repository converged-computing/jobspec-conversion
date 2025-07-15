#!/bin/bash
#FLUX: --job-name=strawberry-butter-1804
#FLUX: -n=4
#FLUX: --queue=maxwell
#FLUX: -t=432000
#FLUX: --priority=16

setpkgs -a tensorflow_0.12
python  /scratch/yaoy4/BodySegmentation/run.py evaluate random
python  /scratch/yaoy4/BodySegmentation/run.py evaluate
python  /scratch/yaoy4/BodySegmentation/run.py evaluate random
python  /scratch/yaoy4/BodySegmentation/run.py evaluate
python  /scratch/yaoy4/BodySegmentation/run.py evaluate random
python  /scratch/yaoy4/BodySegmentation/run.py evaluate
python  /scratch/yaoy4/BodySegmentation/run.py evaluate random
python  /scratch/yaoy4/BodySegmentation/run.py evaluate
python  /scratch/yaoy4/BodySegmentation/run.py evaluate random

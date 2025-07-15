#!/bin/bash
#FLUX: --job-name=strawberry-noodle-1847
#FLUX: --queue=train
#FLUX: -t=1209600
#FLUX: --urgency=16

for i in 1 2 3 4 5
do
     for batch in 1024 2048
     do
          python main.py --quan 1 --world-size 8 --rank 0 --workers 64 --batch-size $batch --arch resnet50
     done
done

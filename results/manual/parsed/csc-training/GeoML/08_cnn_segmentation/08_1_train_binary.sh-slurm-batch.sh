#!/bin/bash
#FLUX: --job-name=cowy-dog-7469
#FLUX: -c=5
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --urgency=16

module load tensorflow
echo $LOCAL_SCRATCH
tar xf trainingTilesBinary_1024.tar -C $LOCAL_SCRATCH
ls $LOCAL_SCRATCH
srun python3 08_1_train.py $LOCAL_SCRATCH 2

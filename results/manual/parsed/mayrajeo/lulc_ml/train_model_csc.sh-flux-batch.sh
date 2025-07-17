#!/bin/bash
#FLUX: --job-name=LULC_UNET_training
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --urgency=16

echo "$(date)"
module purge
module load python-env/3.5.3-ml
cd $WRKDIR/lulc_ml
python train_model.py 
echo "$(date)"
seff $SLURM_JOBID

#!/bin/bash
#FLUX: --job-name=crusty-knife-7259
#FLUX: -c=2
#FLUX: --urgency=16

echo "$(date)"
module purge
module load python-env/3.5.3-ml
cd $WRKDIR/lulc_ml
python train_model.py 
echo "$(date)"
seff $SLURM_JOBID

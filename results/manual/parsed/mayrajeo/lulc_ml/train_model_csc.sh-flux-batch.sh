#!/bin/bash
#FLUX: --job-name=frigid-underoos-2768
#FLUX: -c=2
#FLUX: --priority=16

echo "$(date)"
module purge
module load python-env/3.5.3-ml
cd $WRKDIR/lulc_ml
python train_model.py 
echo "$(date)"
seff $SLURM_JOBID

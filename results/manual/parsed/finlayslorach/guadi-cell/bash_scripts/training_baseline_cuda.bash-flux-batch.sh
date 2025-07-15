#!/bin/bash
#FLUX: --job-name=multilabel_model
#FLUX: --queue=stv-gpu
#FLUX: -t=259200
#FLUX: --priority=16

module purge 
module load anaconda3
source activate fastai
python /hpc/scratch/hdd2/fs541623/Cell_Tox_Assay_080421/FEATURE_EXTRACTION/ModelTest.py 

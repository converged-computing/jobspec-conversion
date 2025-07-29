#!/bin/bash
#FLUX: --job-name=m6_mrnet
#FLUX: -c=8
#FLUX: -t=457200
#FLUX: --urgency=16

module load python/3.7
module load openslide
virtualenv --no-download $SLURM_TMPDIR/venv
source $SLURM_TMPDIR/venv/bin/activate
pip install --no-index --upgrade pip
pip install -r /scratch/authorid/BRATS_IDH/code/requirement.txt
cd /scratch/authorid/shortcut/MRNet/
python train.py --rundir /scratch/authorid/shortcut/log/MRNet/meniscus/seed6 --task meniscus --backbone resnet18 --seed 6

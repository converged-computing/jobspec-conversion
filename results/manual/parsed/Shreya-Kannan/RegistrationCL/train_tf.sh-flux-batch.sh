#!/bin/bash
#FLUX: --job-name=doopy-parsnip-8234
#FLUX: -N=2
#FLUX: -n=32
#FLUX: -t=126000
#FLUX: --urgency=16

module load python
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install voxelmorph
pip install tensorflow
pip install numpy==1.23.5
pip install "nibabel<5"
NOW=$(date '+%Y%m%d%H%M%S')
python /home/shreya/scratch/train_tf_nmi.py

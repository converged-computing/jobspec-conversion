#!/bin/bash
#FLUX: --job-name=OSP
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load cuda/10.0.130
module load gnu7
module load openmpi3
module load anaconda/3.6
source activate /opt/ohpc/pub/apps/tensorflow_2.0.0
python3.7 -m pip install --user scikit-image
python3.7 -m pip install --user nibabel
cd src
srun -n 1 python3 -m preprocessing.prepare_tfrecords

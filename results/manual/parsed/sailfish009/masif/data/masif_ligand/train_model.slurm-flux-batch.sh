#!/bin/bash
#FLUX: --job-name=gassy-motorcycle-1827
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

export MONET_DIR='/home/gainza/lpdi_fs/seednet/monet_seeder/'
export PYTHONPATH='$PYTHONPATH:$masif_source'

module purge
slmodules -r deprecated
module load gcc/5.4.0 cuda cudnn mvapich2 openblas
source /home/gainza/lpdi_fs/seednet/monet_seeder/tensorflow_on_gpu/bin/activate
export MONET_DIR=/home/gainza/lpdi_fs/seednet/monet_seeder/
export PYTHONPATH=$PYTHONPATH:$MONET_DIR:./
masif_root=$(git rev-parse --show-toplevel)
masif_source=$masif_root/source/
masif_matlab=$masif_root/source/matlab_libs/
export PYTHONPATH=$PYTHONPATH:$masif_source
srun python -u $masif_source/masif_ligand/masif_ligand_train.py

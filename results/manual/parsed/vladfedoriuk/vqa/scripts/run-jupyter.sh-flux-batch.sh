#!/bin/bash
#FLUX: --job-name=jupyter
#FLUX: -c=10
#FLUX: --queue=student
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:$PWD'

cd $HOME/vqa || exit
export PYTHONPATH=.:$PYTHONPATH
export PYTHONPATH=$PYTHONPATH:$PWD
singularity exec \
  --nv \
  -B .:/app \
  -B /shared/sets/datasets:/shared/sets/datasets \
  -B ~/.local/share:/.local/share /shared/sets/singularity/miniconda_pytorch_py310.sif \
  bash scripts/jupyter.sh
exit 0

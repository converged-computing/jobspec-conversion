#!/bin/bash
#FLUX: --job-name=jupyter
#FLUX: -c=40
#FLUX: --urgency=16

module purge
module load python/intel/3.8.6
pip install --no-index --upgrade pip
pip install --no-index -r requirements.txt
singularity exec \
    --overlay $HOME/overlay-5GB-200K.ext3 \
    /scratch/work/public/singularity/cuda11.0-cudnn8-devel-ubuntu18.04.sif \
    /bin/bash -c "source ~/.bash_profile;
                  ipython $HOME/ml-explainability/$1.py"

#!/bin/bash
#FLUX: --job-name=heppy
#FLUX: --queue=normal
#FLUX: --urgency=16

module purge
spack load --dependencies miniconda3
spack load --dependencies cuda@11.1
source /mnt/beegfs/sinai-cern/heppy/cern-heppy/venv/bin/activate
srun python $1

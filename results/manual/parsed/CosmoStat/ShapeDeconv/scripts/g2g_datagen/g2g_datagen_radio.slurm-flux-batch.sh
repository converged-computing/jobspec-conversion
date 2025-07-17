#!/bin/bash
#FLUX: --job-name=gpu_mono
#FLUX: -c=30
#FLUX: -t=72000
#FLUX: --urgency=16

export OMP_NUM_THREADS='30'

module purge
module load tensorflow-gpu/py3/1.15.2
set -x
export OMP_NUM_THREADS=30
/gpfswork/rech/xdy/uze68md/GitHub/galaxy2galaxy/galaxy2galaxy/bin/g2g-datagen --problem=meerkat_3600 --data_dir=$WORK/data/meerkat_3600 --tmp_dir=$WORK/data/

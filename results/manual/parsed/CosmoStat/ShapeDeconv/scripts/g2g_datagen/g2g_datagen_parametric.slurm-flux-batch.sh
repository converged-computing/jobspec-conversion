#!/bin/bash
#FLUX: --job-name=gpu_mono
#FLUX: -c=10
#FLUX: -t=28800
#FLUX: --urgency=16

export OMP_NUM_THREADS='10'

module purge
module load tensorflow-gpu/py3/1.15.2
set -x
export OMP_NUM_THREADS=10
/gpfswork/rech/xdy/uze68md/GitHub/galaxy2galaxy/galaxy2galaxy/bin/g2g-datagen --problem=attrs2img_cosmos_parametric_cfht2hst --data_dir=$WORK/data/attrs2img_cosmos_parametric_cfht2hst --tmp_dir=$WORK/data/

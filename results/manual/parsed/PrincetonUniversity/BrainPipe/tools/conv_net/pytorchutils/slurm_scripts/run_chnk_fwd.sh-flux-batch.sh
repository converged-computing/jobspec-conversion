#!/bin/bash
#FLUX: --job-name=tart-omelette-6445
#FLUX: --priority=16

echo "Array Index: $SLURM_ARRAY_TASK_ID"
module load cudatoolkit/10.0 cudnn/cuda-10.0/7.3.1 anaconda3/5.3.1
. activate 3dunet
cd pytorchutils/
python run_chnk_fwd.py exp2 /tigress/ahoag/cnn/exp2  models/RSUNet.py 12000 --gpus 0 --noeval --tag exp2 ${SLURM_ARRAY_TASK_ID}

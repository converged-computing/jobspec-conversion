#!/bin/bash
#FLUX: --job-name=salted-truffle-0721
#FLUX: --urgency=16

echo "Array Index: $SLURM_ARRAY_TASK_ID"
module load cudatoolkit/10.0 cudnn/cuda-10.0/7.3.1 anaconda3/5.3.1
. activate 3dunet
cd pytorchutils/
python run_chnk_fwd.py 20200316_peterb_zd_train  models/RSUNet.py 12000 z265 --gpus 0 --noeval --tag noeval ${SLURM_ARRAY_TASK_ID}

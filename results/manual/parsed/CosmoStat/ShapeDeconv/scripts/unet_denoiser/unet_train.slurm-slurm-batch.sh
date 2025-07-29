#!/bin/bash
#FLUX: --job-name=unet_train
#FLUX: -c=10
#FLUX: -t=360000
#FLUX: --urgency=16

module purge
module load tensorflow-gpu/py3/1.15.2
set -x
cd $WORK/GitHub/ShapeDeconv/scripts/unet_denoiser
python ./unet_train.py --data_dir=/gpfswork/rech/xdy/uze68md/data/attrs2img_cosmos_parametric_cfht2hst/ --model_dir=/gpfswork/rech/xdy/uze68md/trained_models/model_cfht/ --n_col=64 --n_row=64 --batch_size=32 --steps=6500 --epochs=20

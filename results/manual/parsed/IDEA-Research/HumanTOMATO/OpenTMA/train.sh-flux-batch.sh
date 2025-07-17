#!/bin/bash
#FLUX: --job-name=X-TMR
#FLUX: -c=18
#FLUX: --queue=cvr
#FLUX: --urgency=16

source activate temos
python -m train --cfg configs/configs_temos/H3D-TMR.yaml --cfg_assets configs/assets.yaml --nodebug

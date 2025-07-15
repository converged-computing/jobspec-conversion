#!/bin/bash
#FLUX: --job-name=purple-caramel-5024
#FLUX: -c=18
#FLUX: --priority=16

source activate temos
python -m train --cfg configs/configs_temos/H3D-TMR.yaml --cfg_assets configs/assets.yaml --nodebug

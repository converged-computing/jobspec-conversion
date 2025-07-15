#!/bin/bash
#FLUX: --job-name=stanky-eagle-4039
#FLUX: -c=18
#FLUX: --urgency=16

source activate temos
python -m train --cfg configs/configs_temos/H3D-TMR.yaml --cfg_assets configs/assets.yaml --nodebug

#!/bin/bash
#FLUX: --job-name=milky-frito-4484
#FLUX: -n=12
#FLUX: --queue=volta-gpu
#FLUX: -t=864000
#FLUX: --urgency=16

source activate tf_v100
python ./langevin_dynamics.py --sample_size=2048 -m pointcnn_seg -x shapenet_generation  -l /pine/scr/s/s/ssy95/models/generation/pointcnn_seg_shapenet_generation_2019-12-08-03-11-41_52349/ckpts  --grid_size=1

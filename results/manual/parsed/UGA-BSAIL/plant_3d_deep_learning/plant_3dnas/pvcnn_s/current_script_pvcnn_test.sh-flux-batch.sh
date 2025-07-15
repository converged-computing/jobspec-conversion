#!/bin/bash
#FLUX: --job-name=pvcnn_shapenet_p100
#FLUX: -c=4
#FLUX: --queue=patterli_p
#FLUX: -t=172800
#FLUX: --urgency=16

cd /scratch/fs47816/workdir/sample_scripts/pvcnn_s/pvcnn
ml TensorFlow/2.2.0-fosscuda-2019b-Python-3.7.4
ml protobuf/3.10.0-GCCcore-8.3.0
ml tensorboard/2.4.1-fosscuda-2019b-Python-3.7.4
ml PyTorch/1.6.0-fosscuda-2019b-Python-3.7.4
ml tqdm/4.41.1-GCCcore-8.3.0
ml numba/0.47.0-fosscuda-2019b-Python-3.7.4
ml Ninja/1.9.0-GCCcore-8.3.0
python train.py configs/shapenet/pvcnn/c1.py --devices 0 --evaluate

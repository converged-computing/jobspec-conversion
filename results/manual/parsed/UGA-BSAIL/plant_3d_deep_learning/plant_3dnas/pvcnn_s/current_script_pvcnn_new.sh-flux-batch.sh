#!/bin/bash
#FLUX: --job-name=pvcnn_shapenet_p100
#FLUX: -c=4
#FLUX: --queue=gpu_p
#FLUX: -t=172800
#FLUX: --urgency=16

cd /scratch/fs47816/workdir/sample_scripts/pvcnn_s/pvcnn
ml TensorFlow/2.4.1-fosscuda-2020b
ml protobuf/3.14.0-GCCcore-10.2.0
ml tensorboard/2.8.0-fosscuda-2020b-Python-3.8.6
ml PyTorch/1.10.0-fosscuda-2020b-Python-3.8.6
ml tqdm/4.61.2-GCCcore-10.2.0
ml numba/0.55.1-fosscuda-2020b-Python-3.8.6
ml Ninja/1.10.1-GCCcore-10.2.0
ml scikit-learn/0.24.2-fosscuda-2020b
python train.py configs/shapenet/pvcnn/c1.py --devices 0 

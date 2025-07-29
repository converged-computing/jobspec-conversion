#!/bin/bash
#FLUX: --job-name=train
#FLUX: --queue=gpu
#FLUX: -t=163800
#FLUX: --urgency=16

echo $PATH
module list
nvidia-smi
module load CUDA/9.0.176 ; module load cuDNN/7.0.5-CUDA-9.0.176 ; module load OpenCV/3.4.1-foss-2017b-Python-2.7.14-CUDA-9.0.176 ;module load Cython/0.25.2-GCCcore-6.3.0-Python-2.7.12-bare ; module load GCCcore/4.9.3 ; source activate fast-rcnn1-copy ; export PYTHONPATH= ; export LD_LIBRARY_PATH=/scratch/user/nirajgoel/anaconda3/envs/fast-rcnn1/lib/:$LD_LIBRARY_PATH
./tools/train_net.py --gpu 0 --solver models/aod_fast_rcnn_v2/solver.prototxt --weights data/faster_rcnn_models/ResNet101_BN_SCALE_Merged.caffemodel --imdb voc_0712_trainval --iters 70000 --cfg experiments/cfgs/faster_rcnn_end2end.yml

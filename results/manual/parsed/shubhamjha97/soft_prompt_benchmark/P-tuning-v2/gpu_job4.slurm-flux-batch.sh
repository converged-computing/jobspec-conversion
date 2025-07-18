#!/bin/bash
#FLUX: --job-name=P-Tuning-v2-copa-gpt2
#FLUX: -c=4
#FLUX: --queue=n1s8-v100-1
#FLUX: -t=14400
#FLUX: --urgency=16

singularity exec --nv --bind /scratch --overlay /scratch/ask9126/overlay-25GB-500K.ext3:ro /scratch/ask9126/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif /bin/bash -c "
source /ext3/env.sh
conda create -n pt2 python=3.8.5
conda activate pt2
conda install -n pt2 pytorch==1.7.1 torchvision==0.8.2 torchaudio==0.7.2 cudatoolkit=11.0 -c pytorch
pip install -r requirements.txt
bash run_script/run_copa_gpt2.sh
"

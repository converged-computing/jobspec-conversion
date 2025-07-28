#!/bin/bash
#FLUX: --job-name=D-DETR_test
#FLUX: -t=10800
#FLUX: --urgency=16

conda create -n deformable_detr python=3.7 pip
conda activate deformable_detr
conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch
pip install -r requirements.txt
cd Deformable-DETR
cd ./models/ops
sh ./make.sh
python test.py

#!/bin/bash
#FLUX: --job-name=hy34_build_modules
#FLUX: --queue=V100
#FLUX: --urgency=16

echo $CUDA_VISIBLE_DEVICES
source /mnt/home/v_youhaoran/anaconda3/etc/profile.d/conda.sh
source /mnt/home/v_youhaoran/.bashrc
conda activate nas
echo 'start'
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
cd fairseq/modules/lightadd_layer
python setup.py install
cd ../../..
cd fairseq/modules/lightconv_layer
python setup.py install
cd ../../..
cd fairseq/modules/lightshiftadd_layer
python setup.py install
cd ../../..
echo 'end'

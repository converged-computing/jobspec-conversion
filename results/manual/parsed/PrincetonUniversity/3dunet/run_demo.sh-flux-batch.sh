#!/bin/bash
#FLUX: --job-name=expensive-blackbean-1552
#FLUX: -N=2
#FLUX: --queue=all
#FLUX: -t=600
#FLUX: --urgency=16

module load cudatoolkit/10.0 cudnn/cuda-10.0/7.3.1 anaconda3/5.3.1
. activate 3dunet
echo 'Folder to save: '
demo_folder=$(pwd)$'/demo'
echo $demo_folder
python setup_demo_script.py $demo_folder
cd pytorchutils
echo $(pwd)
python demo.py demo models/RSUNet.py samplers/demo_sampler.py augmentors/flip_rotate.py 10 --batch_sz 1 --nobn --noeval --tag demo

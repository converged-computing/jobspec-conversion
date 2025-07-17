#!/bin/bash
#FLUX: --job-name=testTensorFlow
#FLUX: --queue=shared-gpu
#FLUX: -t=14400
#FLUX: --urgency=16

module load GCC/10.3.0  OpenMPI/4.1.1 TensorFlow/2.6.0
module load cuDNN/8.2.1.32-CUDA-11.3.1
rm -r project 
virtualenv project
source project/bin/activate
pip install -U pip
pip uninstall scikit-learn
pip install scikit-learn==1.1.1
pip uninstall pytz
pip install pytz==2022.1
pip uninstall six 
pip install six==1.16.0
pip install matplotlib==3.5.2
pip install opencv-python==4.6.0.66
pip install opencv-contrib-python==4.6.0.66
pip install -v -r  ./requirements.txt
pip install split-folders
srun python ./main_ann_lasso_classification_2layer.py ./MNIST_4 35 4

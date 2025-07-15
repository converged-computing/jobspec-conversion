#!/bin/bash
#FLUX: --job-name=FredericMasterThesisGAN
#FLUX: -t=259200
#FLUX: --priority=16

module load python/3.8.7
module load cuda/11.4
module load cudnn/8.4.0
pip3 install --user -r requirements.txt
python3 -c "import tensorflow as tf; print(tf.__version__)"
python3 -c "import tensorflow as tf; print('Num GPUs Available: ', len(tf.config.list_physical_devices('GPU')))"
python3 trainer/TrainNeuralNetwork.py

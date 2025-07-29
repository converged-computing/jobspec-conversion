#!/bin/bash
#SBATCH --job-name=FredericMasterThesisGAN
#SBATCH --output=output_%J.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:volta:1
#SBATCH --mem=32G
#SBATCH --time=3-00:00:00

module load python/3.8.7
module load cuda/11.4
module load cudnn/8.4.0
pip3 install --user -r requirements.txt
python3 -c "import tensorflow as tf; print(tf.__version__)"
python3 -c "import tensorflow as tf; print('Num GPUs Available: ', len(tf.config.list_physical_devices('GPU')))"
python3 trainer/TrainNeuralNetwork.py

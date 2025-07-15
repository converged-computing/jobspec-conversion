#!/bin/bash
#FLUX: --job-name=cowy-staircase-4471
#FLUX: --priority=16

export PATH='/homedtic/rgong/anaconda2/bin:$PATH'

module load Tensorflow/1.5.0-foss-2017a-Python-2.7.12
export PATH=/homedtic/rgong/anaconda2/bin:$PATH
source activate /homedtic/rgong/keras_env
python /homedtic/rgong/phoneEmbeddingModelsTraining/training_scripts/hpcDLScriptsPhoneEmbedding/embedding_rnn_siamese_train_Ndiff.py

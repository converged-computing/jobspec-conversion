#!/bin/bash
#SBATCH --job-name=emb_nd_5
#SBATCH --output=/homedtic/rgong/phoneEmbeddingModelsTraining/out/emb_siamese_nd_5.%N.%J.%u.out
#SBATCH --error=/homedtic/rgong/phoneEmbeddingModelsTraining/out/emb_siamese_nd_5.%N.%J.%u.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --partition=high
#SBATCH --chdir=/homedtic/rgong/phoneEmbeddingModelsTraining
#SBATCH --nodelist=node021

export PATH='/homedtic/rgong/anaconda2/bin:$PATH'

module load Tensorflow/1.5.0-foss-2017a-Python-2.7.12
export PATH=/homedtic/rgong/anaconda2/bin:$PATH
source activate /homedtic/rgong/keras_env
python /homedtic/rgong/phoneEmbeddingModelsTraining/training_scripts/hpcDLScriptsPhoneEmbedding/embedding_rnn_siamese_train_Ndiff.py

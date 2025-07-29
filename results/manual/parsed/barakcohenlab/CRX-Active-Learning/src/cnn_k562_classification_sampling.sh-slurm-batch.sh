#!/bin/bash
#SBATCH --output=log/cnn_k562_classification_sampling.out-%A_%a
#SBATCH --error=log/cnn_k562_classification_sampling.err-%A_%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=8G
#SBATCH --array=1-10%3

eval $(spack load --sh miniconda3)
source activate active-learning
if [ -z ${SLURM_ARRAY_TASK_ID} ] ; then
    fold=1
else
    fold=${SLURM_ARRAY_TASK_ID}
fi
dirname=ModelFitting/K562/OneRound/${fold}
mkdir -p $dirname
python3 src/cnn_k562_classification_sampling.py $dirname --fold $fold --upper_bound --sampling_size 5000 3000 1000 --initial_data 5000
python3 src/cnn_k562_classification_sampling.py $dirname --fold $fold --sampling_size 5000 3000 1000 --initial_data 4000
python3 src/cnn_k562_classification_sampling.py $dirname --fold $fold --sampling_size 5000 3000 1000 --initial_data 3000

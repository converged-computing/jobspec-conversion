#!/bin/bash
#SBATCH --job-name=vgg19_Predict
#SBATCH --output=logs/vgg19_classification_prediction.out
#SBATCH --error=logs/vgg19_classification_prediction.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --partition=GPUNodes

echo "starting .."
srun singularity exec /logiciels/containerCollections/CUDA9/keras-tf.sif python3 "mc_programs/main.py" -predict True -network vgg19
echo "done"

#!/bin/bash
#SBATCH --account=Project_ID
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --time=00:10:00

ml GCC/10.2.0  CUDA/11.1.1  OpenMPI/4.0.5
ml TensorFlow/2.4.1 
echo "First example hello_tensorflow.py"
python hello_tensorflow.py
echo "     "
echo "Second example loss.py"
python loss.py
echo "     "
echo "Third example mnist_mlp.py" 
ml Keras/2.4.3 
python mnist_mlp.py

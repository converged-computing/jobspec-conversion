#!/bin/bash
#SBATCH --job-name=TensorFlowTest
#SBATCH --output=TensorFlowTest.o%j
#SBATCH --mail-user=jma7@mdanderson.org
#SBATCH --mail-type=end
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=8

module load gcc/4.9.1 cuda/8.0 cudnn/5.1 python3/3.5.2 tensorflow-gpu/1.0.0
python3 /home/05268/junma7/facialExpression/cnn_tf.py 

#!/bin/bash
#SBATCH --job-name=pvcnn_shapenet_p100
#SBATCH --output=%x_%j.out
#SBATCH --mail-user=fs47816@uga.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:A100:1
#SBATCH --mem=30gb
#SBATCH --time=2-00:00:00

cd /scratch/fs47816/workdir/sample_scripts/pvcnn_s/pvcnn
ml TensorFlow/2.4.1-fosscuda-2020b
ml protobuf/3.14.0-GCCcore-10.2.0
ml tensorboard/2.8.0-fosscuda-2020b-Python-3.8.6
ml PyTorch/1.10.0-fosscuda-2020b-Python-3.8.6
ml tqdm/4.61.2-GCCcore-10.2.0
ml numba/0.55.1-fosscuda-2020b-Python-3.8.6
ml Ninja/1.10.1-GCCcore-10.2.0
ml scikit-learn/0.24.2-fosscuda-2020b
python train.py configs/shapenet/pvcnn/c1.py --devices 0 

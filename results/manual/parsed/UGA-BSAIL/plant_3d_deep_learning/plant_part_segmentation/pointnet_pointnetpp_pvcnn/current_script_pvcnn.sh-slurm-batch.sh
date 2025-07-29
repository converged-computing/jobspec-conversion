#!/bin/bash
#SBATCH --job-name=pvcnn_shapenet_p100
#SBATCH --output=%x_%j.out
#SBATCH --mail-user=fs47816@@uga.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:V100:1
#SBATCH --mem=40gb
#SBATCH --time=2-00:00:00

cd /scratch/fs47816/workdir/sample_scripts/pvcnn_shapenet_p100_pvcnn_plantnet_fullpc3/pvcnn
ml TensorFlow/2.2.0-fosscuda-2019b-Python-3.7.4
ml protobuf/3.10.0-GCCcore-8.3.0
ml tensorboard/2.4.1-fosscuda-2019b-Python-3.7.4
ml PyTorch/1.6.0-fosscuda-2019b-Python-3.7.4
ml tqdm/4.41.1-GCCcore-8.3.0
ml numba/0.47.0-fosscuda-2019b-Python-3.7.4
ml Ninja/1.9.0-GCCcore-8.3.0
python train.py configs/shapenet/pvcnn/c1.py --devices 0

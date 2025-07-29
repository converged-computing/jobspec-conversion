#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=16g
#SBATCH --time=10-00:00:00
#SBATCH --qos=gpu_access

source activate tf_v100
python ./langevin_dynamics.py --sample_size=2048 -m pointcnn_seg -x shapenet_generation  -l /pine/scr/s/s/ssy95/models/generation/pointcnn_seg_shapenet_generation_2019-12-08-03-11-41_52349/ckpts  --grid_size=1

#!/bin/bash
#SBATCH --output=cuda_Training-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --time=3-00:02:00

module load cuda/9.0
source activate maskrcnn
conda install --name maskrcnn numpy
conda install -c anaconda --name maskrcnn scikit-image
/srv/home/whao/anaconda3/envs/maskrcnn/bin/pip install -r requirements.txt
/srv/home/whao/anaconda3/envs/maskrcnn/bin/python3 setup.py install
/srv/home/whao/anaconda3/envs/maskrcnn/bin/python3 ./samples/balloon/balloon.py train --dataset=./datasets/balloon --weights=coco

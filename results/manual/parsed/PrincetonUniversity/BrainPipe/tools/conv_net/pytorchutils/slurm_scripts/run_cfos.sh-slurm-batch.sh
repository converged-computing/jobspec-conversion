#!/bin/bash
#SBATCH --output=cnn_train_cfos.out
#SBATCH --error=cnn_train_cfos.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=10000
#SBATCH --time=15:00:00
#SBATCH --partition=all
#SBATCH --constraint=ntasks-per-node=4,ntasks-per-socket=2

module load cudatoolkit/10.0 cudnn/cuda-10.0/7.3.1 anaconda3/5.3.1
. activate 3dunet
python run_cfos.py 20190607_zd_transfer_learning models/RSUNet.py samplers/soma.py augmentors/flip_rotate.py --batch_sz 500 --chkpt_num 321500 --gpus 0,1,2,3

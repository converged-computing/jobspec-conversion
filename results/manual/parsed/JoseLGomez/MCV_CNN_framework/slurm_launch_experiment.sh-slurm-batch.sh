#!/bin/bash
#SBATCH --output=%x_%u_%j.out
#SBATCH --error=%x_%u_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=16384
#SBATCH --time=00:10:05
#SBATCH --partition=dcc
#SBATCH --chdir=/home/lgomez

sleep 5
/usr/local/cuda-9.2/samples/bin/x86_64/linux/release/deviceQuery
nvidia-smi
cd ~/tmp/MCV_CNN_framework
python main.py --silent --exp_name test01 --exp_folder test01 --config_file config/SemSeg_sample_fcn8_Camvid.yml

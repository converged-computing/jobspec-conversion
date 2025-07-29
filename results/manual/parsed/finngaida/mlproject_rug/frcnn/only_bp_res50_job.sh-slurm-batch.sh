#!/bin/bash
#SBATCH --job-name=Train tf FRCNN Keras model with only bp data resnet50 as backbone not training shared layers
#SBATCH --mail-user=r.malhotra.1@student.rug.nl
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8GB
#SBATCH --time=12:00:00
#SBATCH --partition=gpu

module load Python/3.6.4-foss-2018a
module load tensorflow/1.5.0-foss-2016a-Python-3.5.2-CUDA-9.1.85
cd /data/s3801128/frcnn
pip install -r requirements.txt --user
pip install tensorflow --user
python train_frcnn.py --path train_data_bp.txt --input_weight_path resnet50_initial.h5 --output_weight_path only_bp_res50.hdf5 --config_filename config_only_bp_res50.pickle

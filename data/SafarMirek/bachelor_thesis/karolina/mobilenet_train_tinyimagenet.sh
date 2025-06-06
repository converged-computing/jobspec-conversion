#!/usr/bin/env bash
#PBS -q qgpu
#PBS -N trainMobilenet
#PBS -l select=1:ngpus=1,walltime=08:00:00
#PBS -A OPEN-20-37

echo "Mobilenet Training of float model"

cd /lscratch/$PBS_JOBID || exit

echo "Copy src to local scratch"

cp -vrf /home/${USER}/bachelor_thesis/src/* .

echo "Copy datasets to local scratch for better performance"

cp -vrf /home/${USER}/tensorflow_datasets/ .
export TFDS_DATA_DIR=/lscratch/$PBS_JOBID/tensorflow_datasets

echo "Create symlinks to logs and checkpoints"

ln -s /mnt/proj2/open-20-37/safarmirek/logs logs
ln -s /mnt/proj2/open-20-37/safarmirek/checkpoints checkpoints

echo "Local files:"
ls -l

echo "Install module TensorFlow/2.10.1-foss-2022a-CUDA-11.7.0"

ml TensorFlow/2.10.1-foss-2022a-CUDA-11.7.0
 
echo "Creating virtual environment"

python3 -m venv venv

echo "source venv/bin/activate"

source venv/bin/activate

echo "Installing required packages using pip"

python3 -m pip install -U setuptools wheel pip packaging
python3 -m pip install tensorflow==2.11.0
python3 -m pip install tensorflow-model-optimization==0.7.3
python3 -m pip install tensorflow-metadata==1.12.0
python3 -m pip install protobuf==3.19.6
python3 -m pip install tensorflow-datasets==4.8.2
python3 -m pip install py-paretoarchive==0.19

echo "Running MobileNet 0.25 training"
python3 mobilenet_tinyimagenet_train.py --cache --save-as /mnt/proj2/open-20-37/safarmirek/mobilenet_tinyimagenet_0_25.keras --lr 0.025 --batch-size 64 

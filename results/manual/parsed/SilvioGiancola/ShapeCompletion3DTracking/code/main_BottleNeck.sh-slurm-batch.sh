#!/bin/bash
#FLUX: --job-name=BNeck
#FLUX: -c=9
#FLUX: -t=360000
#FLUX: --urgency=16

echo "Loading anaconda..."
module purge
module load anaconda3
conda create -y -n ShapeCompletion3DTracking python tqdm numpy pandas shapely matplotlib pomegranate
source activate ShapeCompletion3DTracking
conda install -y pytorch=0.4.1 cuda90 -c pytorch
pip install pyquaternion 
echo "...Anaconda env loaded"
echo "Starting training python function ..."
python main.py --batch_size=64 --train_model \
--model_name=BottleNeck$SLURM_ARRAY_TASK_ID \
--dataset_path=/ibex/projects/c2006/KITTI/tracking/training/ \
--bneck_size=$SLURM_ARRAY_TASK_ID
echo "...training function Done"
echo "Starting testing python function ..."
python main.py --test_model \
--model_name=BottleNeck$SLURM_ARRAY_TASK_ID \
--dataset_path=/ibex/projects/c2006/KITTI/tracking/training/ \
--bneck_size=$SLURM_ARRAY_TASK_ID
echo "...testing function Done"

#!/bin/bash
#FLUX: --job-name=ornery-punk-8568
#FLUX: -c=9
#FLUX: -t=360000
#FLUX: --priority=16

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
--model_name=Comp1e-$SLURM_ARRAY_TASK_ID \
--dataset_path=/ibex/projects/c2006/KITTI/tracking/training/ \
--lambda_completion=1e-$SLURM_ARRAY_TASK_ID
echo "...training function Done"
echo "Starting testing python function ..."
python main.py --test_model \
--model_name=Comp1e-$SLURM_ARRAY_TASK_ID \
--dataset_path=/ibex/projects/c2006/KITTI/tracking/training/
echo "...testing function Done"

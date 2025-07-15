#!/bin/bash
#FLUX: --job-name=pusheena-house-3380
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
echo "Define variables..."
echo "... Varaibles defined"
echo "Starting testing python function ..."
python main.py --test_model \
--model_name=Ours \
--dataset_path=/ibex/projects/c2006/KITTI/tracking/training/ \
--search_space=Kalman \
--reference_BB=previous_result \
--number_candidate=$SLURM_ARRAY_TASK_ID
echo "...testing function Done"

#!/bin/bash
#FLUX: --job-name=MainDT
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
echo "Define variables..."
if [ "$SLURM_ARRAY_TASK_ID" -eq "0" ]; then
   model_name="Ours";
   lambda_completion="1e-6"
fi
if [ "$SLURM_ARRAY_TASK_ID" -eq "1" ]; then
   model_name="OnlyTracking";
   lambda_completion="0"
fi
if [ "$SLURM_ARRAY_TASK_ID" -eq "2" ]; then
   model_name="OnlyCompletion";
   lambda_completion="1"
fi
echo "... Variables defined"
echo "Starting testing python function ..."
python main.py --test_model \
--model_name=$model_name \
--dataset_path=/ibex/projects/c2006/KITTI/tracking/training/ \
--detailed_metrics
echo "...testing function Done"

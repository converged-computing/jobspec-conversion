#!/bin/bash
#FLUX: --job-name=SearSpac
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
   search_space="ExhaustiveSearch";
   reference_BB="current_gt"
fi
if [ "$SLURM_ARRAY_TASK_ID" -eq "1" ]; then
   search_space="Kalman";
   reference_BB="previous_result"
fi
if [ "$SLURM_ARRAY_TASK_ID" -eq "2" ]; then
   search_space="Particle";
   reference_BB="previous_result"
fi
if [ "$SLURM_ARRAY_TASK_ID" -eq "3" ]; then
   search_space="GMM25";
   reference_BB="previous_result"
fi
echo "... Varaibles defined"
echo "Starting testing python function ..."
python main.py --test_model \
--model_name=Ours \
--dataset_path=/ibex/projects/c2006/KITTI/tracking/training/ \
--search_space=$search_space \
--reference_BB=$reference_BB \
--number_candidate=147
echo "...testing function Done"

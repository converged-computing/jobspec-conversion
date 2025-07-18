#!/bin/bash
#FLUX: --job-name=Aggreg
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
   model_fusion="pointcloud";
   shape_aggregation="first"
fi
if [ "$SLURM_ARRAY_TASK_ID" -eq "1" ]; then
   model_fusion="pointcloud";
   shape_aggregation="previous"
fi
if [ "$SLURM_ARRAY_TASK_ID" -eq "2" ]; then
   model_fusion="pointcloud";
   shape_aggregation="firstandprevious"
fi
if [ "$SLURM_ARRAY_TASK_ID" -eq "3" ]; then
   model_fusion="pointcloud";
   shape_aggregation="all"
fi
if [ "$SLURM_ARRAY_TASK_ID" -eq "4" ]; then
   model_fusion="latent";
   shape_aggregation="first"
fi
if [ "$SLURM_ARRAY_TASK_ID" -eq "5" ]; then
   model_fusion="latent";
   shape_aggregation="previous"
fi
if [ "$SLURM_ARRAY_TASK_ID" -eq "6" ]; then
   model_fusion="latent";
   shape_aggregation="firstandprevious"
fi
if [ "$SLURM_ARRAY_TASK_ID" -eq "7" ]; then
   model_fusion="latent";
   shape_aggregation="AVG"
fi
if [ "$SLURM_ARRAY_TASK_ID" -eq "8" ]; then
   model_fusion="latent";
   shape_aggregation="MEDIAN"
fi
if [ "$SLURM_ARRAY_TASK_ID" -eq "9" ]; then
   model_fusion="latent";
   shape_aggregation="MAX"
fi
echo "... Varaibles defined"
echo "Starting testing python function ..."
python main.py --test_model \
--model_name=Ours \
--dataset_path=/ibex/projects/c2006/KITTI/tracking/training/ \
--model_fusion=$model_fusion \
--shape_aggregation=$shape_aggregation
echo "...testing function Done"

#!/bin/bash
#SBATCH --job-name=Prop_KF
#SBATCH --output=%x.%3a.%A.out
#SBATCH --error=%x.%3a.%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=9
#SBATCH --gres=gpu
#SBATCH --mem=40G
#SBATCH --time=4-04:00:00
#SBATCH --array=[1,10,20,40,60,80,100,120,140,160]

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

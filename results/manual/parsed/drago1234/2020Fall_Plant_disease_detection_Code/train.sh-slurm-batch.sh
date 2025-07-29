#!/bin/bash
#SBATCH --job-name=plant_disease_diagnosis
#SBATCH --account=PAA0023
#SBATCH --output=/users/PAA0023/dong760/plant_leaves_diagnosis/outputs/MobileNetV3Small_model_BatchSize_32_0.2ValSplit_19-12-2020
#SBATCH --mail-user=dong.760@osu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=48

export PYTHONNOUSERSITE='true'

echo 'environemnt set up'
source ./miniconda3/bin/activate
module load cuda/11.0.3 
export PYTHONNOUSERSITE=true
conda activate tf_latest
echo 'Running the batch script'
python plant_leaves_diagnosis/InceptionV3_model.py # baseline_backup.py baseline_InceptionV3.py baseline_ResNet.py baseline_debug.py baseline_NASNet.py
echo 
qstat -u dong760 
echo 'The date when running current script is :'
date

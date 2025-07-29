#!/bin/bash
#SBATCH --job-name=Aug2_CRNN_Model
#SBATCH --output=jobsOut/job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a30:1
#SBATCH --mem=120G
#SBATCH --time=2-02:00:00

echo "Running on $(hostname):"
module load singularity
pip install tensorcross
singularity exec --nv /opt/itu/containers/tensorflow/tensorflow-23.05-tf2-py3.sif python ClusterTrainingAug2.py

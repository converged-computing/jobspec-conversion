#!/bin/bash
#SBATCH --job-name=Baseline_CRNN_Model
#SBATCH --output=jobsOut/job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a30:1
#SBATCH --mem=160G
#SBATCH --time=1-06:00:00
#SBATCH --partition=brown

echo "Running on $(hostname):"
module load singularity
pip install tensorcross
singularity exec --nv /opt/itu/containers/tensorflow/tensorflow-23.05-tf2-py3.sif python ClusterTrainingBaseline_New.py

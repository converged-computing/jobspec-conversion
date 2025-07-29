#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=4
#SBATCH --partition=gpu
#SBATCH: --no-requeue

IMG=/home/software/singularity/tf26.simg:latest
cd ~/particleflow
PYTHONPATH=hep_tfds singularity exec -B /scratch-persistent --nv $IMG python3 mlpf/pipeline.py train -c parameters/cms.yaml --plot-freq 1

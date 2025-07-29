#!/bin/bash
#SBATCH --account=psychology_gpu_acc
#SBATCH --output=../logs/master/hubReps/hubRep_%a.out
#SBATCH --mail-user=jason.k.chow@vanderbilt.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=06:00:00
#SBATCH --partition=pascal
#SBATCH --array=0-1

date
singularity exec --nv ../pyTF.sif python ../python_scripts/hubReps.py -i ${SLURM_ARRAY_TASK_ID} -d /scratch/chowjk/tensorflow_datasets -f ~/idvor/python_scripts/hubModels.json
date

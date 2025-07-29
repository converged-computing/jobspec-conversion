#!/bin/bash
#SBATCH --job-name=Full1
#SBATCH --account=scinet
#SBATCH --mail-user=$daniel.kick@usda.gov
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12-02:00:00
#SBATCH --constraint=ntasks-per-node=40

module load singularity
singularity instance start ../../../tensorflow/tensorflow-21.07-tf2-py3.sif tf2py3
cd "$PWD"
singularity exec instance://tf2py3 python model_eval_1.py

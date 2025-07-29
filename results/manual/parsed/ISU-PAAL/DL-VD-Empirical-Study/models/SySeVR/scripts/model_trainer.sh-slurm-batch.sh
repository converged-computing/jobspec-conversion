#!/bin/bash
#SBATCH --job-name=Model Trainer
#SBATCH --output=<ANONYMOUS>/<ANONYMOUS>/sysevr/jobs/logs/model_trainer.out
#SBATCH --error=<ANONYMOUS>/<ANONYMOUS>/sysevr/jobs/logs/model_trainer.err
#SBATCH --mail-user=<ANONYMOUS>@iastate.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:1
#SBATCH --mem=256G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu

module load  python/3.6.5-fwk5uaj
module load tensorflow-gpu/1.2.1/u16-cuda8.0-libcudnn5.1-py36
path=<ANONYMOUS>/<ANONYMOUS>/sysevr/Implementation/model
cd $path
tf-gpu python bgru.py

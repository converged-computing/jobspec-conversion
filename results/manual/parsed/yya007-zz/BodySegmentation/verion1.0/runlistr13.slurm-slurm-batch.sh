#!/bin/bash
#SBATCH --account=p_masi_gpu
#SBATCH --output=/scratch/yaoy4/log/test-random-list13.log
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=40G
#SBATCH --time=5-00:00:00

setpkgs -a tensorflow_0.12
python  /scratch/yaoy4/BodySegmentation/run.py randomtrain 13
python  /scratch/yaoy4/BodySegmentation/run.py randomtrain 13
python  /scratch/yaoy4/BodySegmentation/run.py randomtrain 13
python  /scratch/yaoy4/BodySegmentation/run.py randomtrain 13
python  /scratch/yaoy4/BodySegmentation/run.py randomtrain 13
python  /scratch/yaoy4/BodySegmentation/run.py randomtrain 13

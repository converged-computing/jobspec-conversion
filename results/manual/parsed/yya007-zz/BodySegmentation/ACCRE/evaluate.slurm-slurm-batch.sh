#!/bin/bash
#SBATCH --account=p_masi_gpu
#SBATCH --output=/scratch/yaoy4/log/test-evaluate.log
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=40G
#SBATCH --time=5-00:00:00

setpkgs -a tensorflow_0.12
python  /scratch/yaoy4/BodySegmentation/run.py evaluate random
python  /scratch/yaoy4/BodySegmentation/run.py evaluate
python  /scratch/yaoy4/BodySegmentation/run.py evaluate random
python  /scratch/yaoy4/BodySegmentation/run.py evaluate
python  /scratch/yaoy4/BodySegmentation/run.py evaluate random
python  /scratch/yaoy4/BodySegmentation/run.py evaluate
python  /scratch/yaoy4/BodySegmentation/run.py evaluate random
python  /scratch/yaoy4/BodySegmentation/run.py evaluate
python  /scratch/yaoy4/BodySegmentation/run.py evaluate random

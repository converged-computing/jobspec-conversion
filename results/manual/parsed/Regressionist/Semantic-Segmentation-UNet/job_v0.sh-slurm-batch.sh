#!/bin/bash
#SBATCH --job-name=CITY_V0
#SBATCH --output=output_v0.out
#SBATCH --error=error_v0.err
#SBATCH --mail-user=sk7685@nyu.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:1
#SBATCH --mem=12000
#SBATCH --time=1-23:58:00
#SBATCH --qos=batch
#SBATCH --constraint=gpu_12gb

module load python-3.6
module load cuda-10.0
source /data/sk7685/pytorch_10/bin/activate pytorch_10
srun python3 train.py -s 0 -e 10 -a 0 -v v0 -w wv0 -x wv0 -o adam -l 0.001 -d 0.20 -m 100
srun python3 train.py -s 10 -e 15 -a 1 -v v0 -w wv0 -x wv0 -o adam -l 0.001 -d 0.20 -m 100
srun python3 train.py -s 25 -e 40 -a 0 -v v0 -w wv0 -x wv0 -o adam -l 0.001 -d 0.20 -m 100

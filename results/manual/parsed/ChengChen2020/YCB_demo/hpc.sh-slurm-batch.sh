#!/bin/bash
#SBATCH --job-name=ycb_demo
#SBATCH --mail-user=cc6858@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=02:00:00

cd /scratch/$USER/YCB_demo
module purge
module load python/intel/3.8.6
pip install -r requirements.txt
./experiments/scripts/ycb_video_test.sh

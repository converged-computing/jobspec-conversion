#!/bin/bash
#SBATCH --output=outfiles/etl1.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=14g
#SBATCH --time=6-00:00:00

source activate pytorch_p37
cd /home/ianpan/ufrc/deepfake/skp/etl
/home/ianpan/anaconda3/envs/pytorch_p37/bin/python face_xray.py --start 25000 --end 50000

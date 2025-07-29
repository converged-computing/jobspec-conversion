#!/bin/bash
#SBATCH --job-name=predict_everglades
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/everglades_predict%j.out
#SBATCH --error=/home/b.weinstein/logs/everglades_predict%j.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=30GB
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu

export PATH='${PATH}:/home/b.weinstein/miniconda3/envs/Zooniverse/bin/'
export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/Zooniverse/lib/python3.7/site-packages/'
export LD_LIBRARY_PATH='/home/b.weinstein/miniconda3/envs/Zooniverse/lib/:${LD_LIBRARY_PATH}'
export GDAL_DATA='/home/b.weinstein/miniconda3/envs/Zooniverse/share/gdal'

module load tensorflow/1.14.0
export PATH=${PATH}:/home/b.weinstein/miniconda3/envs/Zooniverse/bin/
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/Zooniverse/lib/python3.7/site-packages/
export LD_LIBRARY_PATH=/home/b.weinstein/miniconda3/envs/Zooniverse/lib/:${LD_LIBRARY_PATH}
export GDAL_DATA=/home/b.weinstein/miniconda3/envs/Zooniverse/share/gdal
cd /home/b.weinstein/EvergladesWadingBird/Zooniverse
python predict.py
python nest_detection.py

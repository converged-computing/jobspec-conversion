#!/bin/bash
#SBATCH --job-name=allometry
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/allometry_%j.out
#SBATCH --error=/home/b.weinstein/logs/allometry_%j.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40GB
#SBATCH --time=3-00:00:00

export SLURM_TMPDIR='/orange/idtrees-collab/tmp/'
export TMPDIR='/orange/idtrees-collab/tmp/'
export PATH='${PATH}:/home/b.weinstein/miniconda3/envs/crowns/bin/'
export PYTHONPATH='${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/crowns/lib/python3.7/site-packages/'
export LD_LIBRARY_PATH='/home/b.weinstein/miniconda3/envs/crowns/lib/:${LD_LIBRARY_PATH}'

export SLURM_TMPDIR=/orange/idtrees-collab/tmp/
export TMPDIR=/orange/idtrees-collab/tmp/
module load tensorflow/1.14.0
export PATH=${PATH}:/home/b.weinstein/miniconda3/envs/crowns/bin/
export PYTHONPATH=${PYTHONPATH}:/home/b.weinstein/miniconda3/envs/crowns/lib/python3.7/site-packages/
export LD_LIBRARY_PATH=/home/b.weinstein/miniconda3/envs/crowns/lib/:${LD_LIBRARY_PATH}
cd /home/b.weinstein/NEON_crown_maps/
python allometry.py

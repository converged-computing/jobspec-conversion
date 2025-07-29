#!/bin/bash
#SBATCH --job-name=cs3730-dataset
#SBATCH --output=output/%x-%A.out
#SBATCH --mail-user=alc307@pitt.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=5-00:00:00
#SBATCH --qos=short
#SBATCH --constraint=amd,ntasks-per-node=1

module load gcc/8.2.0 python/anaconda3.10-2022.10
source activate cs3730
unset PYTHONHOME
unset PYTHONPATH
echo "RUN: `date`"
version=`python dataset.py --version`
echo "RUNNING $version SCRIPT"
python dataset.py -d opus_books opus_wikipedia \
                  -s train \
                  -sl en \
                  -tl es \
                  -op 1 \
                  -b 128 \
                  -o datasets/opus \
                  -lo logs
echo "DONE"
command -v crc-job-stats &> /dev/null && command crc-job-stats

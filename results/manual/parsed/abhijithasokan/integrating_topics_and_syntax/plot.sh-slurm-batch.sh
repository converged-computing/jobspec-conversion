#!/bin/bash
#SBATCH --job-name=ITS_plot
#SBATCH --output=./plot.%j.out
#SBATCH --error=./plot.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=2-12:00:00

module purge
module load anaconda3/latest
. $ANACONDA_HOME/etc/profile.d/conda.sh
conda activate integrating_topics_syntax
python plot.py --alpha=0.02 --beta=0.02 --gamma=0.02 --delta=0.02 --num_iter=6000 --num_topics=10 --num_classes=8 --dataset=data2000 --test_dataset=train --test_dataset_size=2000
conda deactivate

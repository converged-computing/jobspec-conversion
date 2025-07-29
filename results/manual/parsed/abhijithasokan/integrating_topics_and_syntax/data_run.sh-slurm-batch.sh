#!/bin/bash
#SBATCH --job-name=ITS
#SBATCH --output=./integrating_topics_syntax.%j.out
#SBATCH --error=./integrating_topics_syntax.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:V100:1
#SBATCH --mem=64000
#SBATCH --time=2-12:00:00

module purge
module load anaconda3/latest
. $ANACONDA_HOME/etc/profile.d/conda.sh
conda activate integrating_topics_syntax
python preprocess_data.py
conda deactivate

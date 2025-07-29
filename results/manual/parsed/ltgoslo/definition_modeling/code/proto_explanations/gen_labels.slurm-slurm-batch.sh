#!/bin/bash
#SBATCH --job-name=definition_labels
#SBATCH --account=ec30
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=1
#SBATCH --mem=8G
#SBATCH --time=05:00:00
#SBATCH --partition=accel

source ${HOME}/.bashrc
module purge
module use -a /fp/projects01/ec30/software/easybuild/modules/all/
module load nlpl-transformers/4.24.0-foss-2021a-Python-3.9.5
module load nlpl-sentencepiece/0.1.96-foss-2021a-Python-3.9.5
module load nlpl-scikit-bundle/1.1.1-foss-2021a-Python-3.9.5
MODEL=${1}  # sentence-transformers/distiluse-base-multilingual-cased-v1 will do for most languages
DATA=${2}  # tsv file with definitions, usages and clusters
OUT=${3}
echo ${MODEL}
echo ${DATA}
python3 sense_label.py --model ${MODEL} --data ${DATA} --bsize 16 --save text --output ${OUT}

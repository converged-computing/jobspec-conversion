#!/bin/bash
#FLUX: --job-name=definition_labels
#FLUX: -c=8
#FLUX: --queue=accel
#FLUX: -t=18000
#FLUX: --urgency=16

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

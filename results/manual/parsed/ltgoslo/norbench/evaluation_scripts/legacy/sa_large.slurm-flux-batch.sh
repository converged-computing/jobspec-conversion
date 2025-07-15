#!/bin/bash
#FLUX: --job-name=norbench
#FLUX: -c=4
#FLUX: --queue=accel
#FLUX: -t=82800
#FLUX: --priority=16

source ${HOME}/.bashrc
set -o errexit
set -o nounset
module purge
module use -a /fp/projects01/ec30/software/easybuild/modules/all/
module load nlpl-transformers/4.20.1-foss-2021a-Python-3.9.5
module load nlpl-nlptools/2022.01-foss-2021a-Python-3.9.5
module load nlpl-datasets/2.3.2-foss-2021a-Python-3.9.5
module load nlpl-sentencepiece/0.1.96-foss-2021a-Python-3.9.5
module load nlpl-wandb/0.13.1-foss-2021a-Python-3.9.5
echo "submission directory: ${SUBMITDIR}"
MODEL=${1}  # Path to the model or its HuggingFace name
IDENTIFIER=${2}
echo ${MODEL}
echo ${IDENTIFIER}
for i in {1..3}
do
    echo ${i}
    python3 finetuning.py -level document -model ${MODEL} -batch_size 8 -epochs 3 --seed ${i} >> ${IDENTIFIER}.txt
done

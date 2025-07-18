#!/bin/bash
#FLUX: --job-name=norbench
#FLUX: -c=4
#FLUX: --queue=ifi_accel
#FLUX: -t=36000
#FLUX: --urgency=16

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
IDENTIFIER=${2}  # identifier to save the reslts and checkpoints with
echo ${MODEL}
echo ${IDENTIFIER}
python3 norbench_run.py --path_to_model ${MODEL} --task all --download_cur_data True --model_name ${IDENTIFIER}

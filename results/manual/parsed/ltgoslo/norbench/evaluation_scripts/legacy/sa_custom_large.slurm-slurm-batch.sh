#!/bin/bash
#SBATCH --job-name=norbench
#SBATCH --account=ec30
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=a100:1
#SBATCH --mem=8G
#SBATCH --time=12:00:00
#SBATCH --partition=accel

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
BSIZE=64
echo ${BSIZE}
for i in {5..6}
do
    echo ${i}
    python3 finetuning2.py -level document -model ${MODEL} -batch_size ${BSIZE} -epochs 3 -custom_wrapper True --seed ${i} >> ${IDENTIFIER}.tsv
done

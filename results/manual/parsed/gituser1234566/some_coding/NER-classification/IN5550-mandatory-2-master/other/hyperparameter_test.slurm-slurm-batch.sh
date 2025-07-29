#!/bin/bash
#SBATCH --job-name=in5550
#SBATCH --account=ec30
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=2
#SBATCH --mem=4G
#SBATCH --time=04:30:00

source ${HOME}/.bashrc
set -o errexit
set -o nounset
module purge
module use -a /fp/projects01/ec30/software/easybuild/modules/all/
module load nlpl-pytorch/2.1.2-foss-2022b-cuda-12.0.0-Python-3.10.8
module load nlpl-torchmetrics/1.2.1-foss-2022b-Python-3.10.8
module load scikit-learn/1.1.2-foss-2022a
module load nlpl-transformers/4.35.2-foss-2022b-Python-3.10.8
echo "submission directory: ${SUBMITDIR}"
python3 hyperparameter_test.py --model "bert-base-multilingual-cased" --batch_size "8,32,64,128" --dropout "0.1,0.5"

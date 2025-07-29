#!/bin/bash
#SBATCH --job-name=in5550
#SBATCH --account=ec30
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=2
#SBATCH --mem=64G
#SBATCH --time=03:30:00
#SBATCH --partition=accel

source ${HOME}/.bashrc
set -o errexit
set -o nounset
module purge
module use -a /fp/projects01/ec30/software/easybuild/modules/all/
module load nlpl-pytorch/2.1.2-foss-2022b-cuda-12.0.0-Python-3.10.8
module load nlpl-torchmetrics/1.2.1-foss-2022b-Python-3.10.8
module load nlpl-transformers/4.35.2-foss-2022b-Python-3.10.8
module load nlpl-nlptools/01-foss-2022b-Python-3.10.8
echo "submission directory: ${SUBMITDIR}"
python3 grid_search.py --batch_size "16,32,64,128" --dropout "0.1,0.3,0.4" --train_language "en-it" --test_language "en" --lr "1e-4,5e-5,2e-5" --epochs 4 --freeze False

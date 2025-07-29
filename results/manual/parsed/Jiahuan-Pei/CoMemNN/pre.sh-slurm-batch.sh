#!/bin/bash
#SBATCH --job-name=$1
#SBATCH --output=./job_out/%x.pre-%A.out
#SBATCH --error=./job_err/%x.pre-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=60G
#SBATCH --time=1-00:00:00

sbatch <<EOT
source ${HOME}/.bashrc
source activate tds_py37_pt
set PYTHONPATH=./
set OMP_NUM_THREADS=2
python -u ./$1/Prepare_dataset.py --data_dir=/ivi/ilps/personal/jpei/TDS $2
EOT

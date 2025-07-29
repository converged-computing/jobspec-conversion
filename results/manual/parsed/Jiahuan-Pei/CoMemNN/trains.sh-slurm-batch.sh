#!/bin/bash
#SBATCH --job-name=$2$3
#SBATCH --output=./job_out/%x.train-%A.out
#SBATCH --error=./job_err/%x.train-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=30G
#SBATCH --time=4-00:00:00

sbatch <<EOT
source ${HOME}/.bashrc
source activate tds_py37_pt
set PYTHONPATH=./
set OMP_NUM_THREADS=2
python -m torch.distributed.launch --nproc_per_node=1 --master_port 29501 ./$2/Run.py --mode='train' --debug=0 --data_dir=/ivi/ilps/personal/jpei/TDS --model_name=$2 --exp_name=$3 $4
EOT

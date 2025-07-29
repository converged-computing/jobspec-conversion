#!/bin/bash
#SBATCH --job-name=train
#SBATCH --account=nlp_lab
#SBATCH --output=sub_outputs/slurm%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --mem=512GB
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=8

export TRANSFORMERS_CACHE='/projects/nlp_lab/zhiyang/.cache/'

module reset
module load gcc/8.2.0
source /home/zhiyangx/miniconda3/etc/profile.d/conda.sh
conda activate lavis
cd /projects/nlp_lab/zhiyang/phd4_projects/VL-Instruct
export TRANSFORMERS_CACHE=/projects/nlp_lab/zhiyang/.cache/
model_type=$1
data_type=$2
output_dir=$3
python -m torch.distributed.run --nproc_per_node=8 train_doremi.py --model_type $model_type --train_qformer --output_dir $output_dir --max_txt_len 512 --train_data_type $data_type

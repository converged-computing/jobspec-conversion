#!/bin/bash
#SBATCH --job-name=TaxoComplete
#SBATCH --output=./TaxoComplete/%x-%j.out
#SBATCH --error=./TaxoComplete/%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=30G
#SBATCH --time=2-05:00:00

echo $(pwd)
module load miniconda/3
module load cuda/11.1
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate taxocomplete
python ./src/evaluate.py --config ./config_files_evaluate/psy/config_clst20_s47.json
python ./src/evaluate.py --config ./config_files_evaluate/psy/config_clst20_s48.json
python ./src/evaluate.py --config ./config_files_evaluate/psy/config_clst20_s49.json
python ./src/train.py --config ./config_files/psy/config_clst20_s47.json
python ./src/train.py --config ./config_files/psy/config_clst20_s48.json
python ./src/train.py --config ./config_files/psy/config_clst20_s49.json
conda deactivate

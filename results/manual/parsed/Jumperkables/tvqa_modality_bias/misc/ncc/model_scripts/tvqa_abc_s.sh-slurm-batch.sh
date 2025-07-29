#!/bin/bash
#SBATCH --job-name=s
#SBATCH --output=/home/crhf63/kable_management/mk8+-tvqa/dataset_paper/ncc/results/tvqa_abc_s.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=12G
#SBATCH --time=2-00:00:00
#SBATCH --qos=short
#SBATCH --exclude=gpu[0-3]

source /home/crhf63/kable_management/python_venvs/mk8-tvqa/bin/activate
python -W ignore /home/crhf63/kable_management/mk8+-tvqa/main.py \
    --input_streams sub \
    --jobname=tvqa_abc_s \
    --results_dir_base=/home/crhf63/kable_management/mk8+-tvqa/dataset_paper/ncc/results/tvqa_abc_s \
    --modelname=tvqa_abc_bert_nofc \
    --lrtype radam \
    --bsz 32 \
    --log_freq 800 \
    --test_bsz 32 \
    --lanecheck_path /home/crhf63/kable_management/mk8+-tvqa/dataset_paper/ncc/results/tvqa_abc_s/lanecheck_dict.pickle
    #--poolnonlin lrelu \
    #--pool_dropout 0.5 \

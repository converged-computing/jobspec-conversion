#!/bin/bash
#SBATCH --job-name=test_direct_finetuning
#SBATCH --output=testing-%x-%j.out
#SBATCH --error=testing-%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=10240
#SBATCH --time=3-00:00:00
#SBATCH --chdir=direct_fine_tuning

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate virtual-env
python -c "print('\n\nStarting with Bert base Evaluation with 13 classes\n\n')"
python test_metrics.py --model_path="curriculum_learning_training/fine_training/bert/checkpoint-343" --tokenizer="textattack/bert-base-uncased-MNLI"
python -c "print('\n\nStarting with Deberta base Evaluation with 13 classes\n\n')"
python test_metrics.py --model_path="curriculum_learning_training/fine_training/deberta/checkpoint-970" --tokenizer="cross-encoder/nli-deberta-base"
python -c "print('\n\nStarting with Distilbert base Evaluation with 13 classes\n\n')"
python test_metrics.py --model_path="curriculum_learning_training/fine_training/distilbert/checkpoint-441" --tokenizer="typeform/distilbert-base-uncased-mnli"
python -c "print('\n\nStarting with Electra base Evaluation with 13 classes\n\n')"
python test_metrics.py --model_path="direct_fine_tuning/fine_training/electra/checkpoint-490" --tokenizer="howey/electra-base-mnli"
python -c "print('\n\nStarting with Roberta base Evaluation with 13 classes\n\n')"
python test_metrics.py --model_path="curriculum_learning_training/fine_training/roberta/checkpoint-441" --tokenizer="cross-encoder/nli-roberta-base"
conda deactivate

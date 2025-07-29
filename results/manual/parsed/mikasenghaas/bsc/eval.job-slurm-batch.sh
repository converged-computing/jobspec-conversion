#!/bin/bash
#SBATCH --job-name=eval
#SBATCH --account=students
#SBATCH --output=job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu
#SBATCH --time=06:00:00
#SBATCH --partition=brown

echo "Running on $(hostname):"
nvidia-smi
hostname
poetry run python src/eval.py -M alexnet -V v0
poetry run python src/eval.py -M googlenet -V v0
poetry run python src/eval.py -M resnet18 -V v0
poetry run python src/eval.py -M resnet50 -V v0
poetry run python src/eval.py -M densenet121 -V v0
poetry run python src/eval.py -M mobilenet_v3_small -V v0
poetry run python src/eval.py -M vit_b_16 -V v0
poetry run python src/eval.py -M efficientnet_v2_s -V v0
poetry run python src/eval.py -M convnext_tiny -V v0
poetry run python src/eval.py -M r2plus1d_18 -V v0
poetry run python src/eval.py -M x3d_s -V v0
poetry run python src/eval.py -M slow_r50 -V v0
poetry run python src/eval.py -M slowfast_r50 -V v0

#!/bin/bash
#FLUX: --job-name=eval
#FLUX: -c=8
#FLUX: --queue=brown
#FLUX: -t=21600
#FLUX: --urgency=16

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

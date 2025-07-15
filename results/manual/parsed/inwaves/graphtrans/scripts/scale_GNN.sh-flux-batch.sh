#!/bin/bash
#FLUX: --job-name=dirty-onion-6117
#FLUX: -t=7200
#FLUX: --priority=16

python main.py --configs configs/NCI1/gcn/scaled_layers_constant_embedding.yml
python main.py --configs configs/NCI1/gcn/scaled_embedding_constant_layers.yml
python main.py --configs configs/NCI1/gcn/scaled_layers_scaled_embedding.yml
python main.py --configs configs/NCI109/gcn/scaled_layers_constant_embedding.yml
python main.py --configs configs/NCI109/gcn/scaled_embedding_constant_layers.yml
python main.py --configs configs/NCI109/gcn/scaled_layers_scaled_embedding.yml

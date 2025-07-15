#!/bin/bash
#FLUX: --job-name=ornery-underoos-5462
#FLUX: -t=7200
#FLUX: --priority=16

python main.py --configs configs/NCI1/gcn/base.yml
python main.py --configs configs/NCI1/gcn-virtual/base.yml
python main.py --configs configs/NCI1/gnn-transformer/no-virtual/gd=128+gdp=0.1+tdp=0.1+l=3+cosine.yml
python main.py --configs configs/NCI1/gnn-transformer/no-virtual/gin+gdp=0.1+tdp=0.1+l=4+cosine.yml
python main.py --configs configs/NCI1/transformer-gnn/no-virtual/gd=128+gdp=0.1+tdp=0.1+l=3+cosine.yml
python main.py --configs configs/NCI1/transformer-gnn/no-virtual/gin+gdp=0.1+tdp=0.1+l=4+cosine.yml
python main.py --configs configs/NCI1/transformer/pooling=cls.yml
python main.py --configs configs/NCI109/gcn/base.yml
python main.py --configs configs/NCI109/gcn-virtual/base.yml
python main.py --configs configs/NCI109/gnn-transformer/no-virtual/gd=128+gdp=0.1+tdp=0.1+l=3+cosine.yml
python main.py --configs configs/NCI109/gnn-transformer/no-virtual/gin+gdp=0.1+tdp=0.1+l=4+cosine.yml
python main.py --configs configs/NCI109/transformer-gnn/no-virtual/gd=128+gdp=0.1+tdp=0.1+l=3+cosine.yml
python main.py --configs configs/NCI109/transformer-gnn/no-virtual/gin+gdp=0.1+tdp=0.1+l=4+cosine.yml
python main.py --configs configs/NCI109/transformer/pooling=cls.yml

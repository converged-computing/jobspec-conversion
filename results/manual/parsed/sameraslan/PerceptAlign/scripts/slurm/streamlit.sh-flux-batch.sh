#!/bin/bash
#FLUX: --job-name=stinky-lettuce-5575
#FLUX: --queue=$PARTITION
#FLUX: -t=36000
#FLUX: --priority=16

module load anaconda
module load cuda/11.6.0
conda activate PerceptAlign
streamlit run --server.port 5554 --server.address 0.0.0.0 ./sample_visualization.py

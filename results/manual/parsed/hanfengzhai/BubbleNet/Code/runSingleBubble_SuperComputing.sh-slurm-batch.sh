#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64

python -u DNN_SingleBubble.py # CUDA / MPI
python -u BubbleNet_SingleBubble.py

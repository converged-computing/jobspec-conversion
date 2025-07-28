#!/bin/bash
#FLUX: --job-name=D2STGNN2021
#FLUX: --gpus-per-task=8
#FLUX: --queue=normal
#FLUX: --urgency=16

/storage/internal/home/y-chiang/miniconda3/bin/python main_stream.py

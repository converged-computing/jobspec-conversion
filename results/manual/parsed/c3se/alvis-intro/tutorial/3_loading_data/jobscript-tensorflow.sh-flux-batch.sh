#!/bin/bash
#FLUX: --job-name=fat-signal-1538
#FLUX: --priority=16

ml purge
ml TensorFlow/2.11.0-foss-2022a-CUDA-11.7.0
ml matplotlib/3.5.2-foss-2022a
ml JupyterLab/3.5.0-GCCcore-11.3.0
ipython -c "%run data-tensorflow.ipynb"

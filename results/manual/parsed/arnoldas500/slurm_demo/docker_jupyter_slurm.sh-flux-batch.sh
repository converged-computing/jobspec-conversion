#!/bin/bash
#FLUX: --job-name=jupyterAE
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

docker run -v /home/aevans:/home/aevans -v /raid/NYSM:/home/aevans/NYSM --name=jupyter_ae -w /home/aevans -u aevans --runtime=nvidia --gpus=1 -p 8886:88
88 akurbanovas/ae.ai2es:v0.1 /opt/conda/bin/jupyter lab --port=8888 --ip=0.0.0.0 --allow-root --no-browser /home/aevans
88 akurbanovas/lg.ai2es:v0.2 python job.py

#!/bin/bash
#FLUX: --job-name=output
#FLUX: -t=21600
#FLUX: --urgency=16

nvidia-docker run -v /home/$USER:/home/$USER mustang/wgan:1.0 python -u ../home/mvenkataraman_ph/Face-Super-Resolution-Through-Wasserstein-GANs/main.py

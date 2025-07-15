#!/bin/bash
#FLUX: --job-name=placid-lemon-4156
#FLUX: --priority=16

source ~/modules/pytorch/latest
python model_inference.py --config-file configs/3D/inference/resmcnet/absorb-64x64x64.yaml
python model_inference.py --config-file configs/3D/inference/resmcnet/absorb-100x100x100.yaml
python model_inference.py --config-file configs/3D/inference/resmcnet/absorb-128x128x128.yaml
python model_inference.py --config-file configs/3D/inference/resmcnet/homo-64x64x64.yaml
python model_inference.py --config-file configs/3D/inference/resmcnet/homo-100x100x100.yaml
python model_inference.py --config-file configs/3D/inference/resmcnet/homo-128x128x128.yaml
python model_inference.py --config-file configs/3D/inference/resmcnet/refractive-64x64x64.yaml
python model_inference.py --config-file configs/3D/inference/resmcnet/refractive-100x100x100.yaml
python model_inference.py --config-file configs/3D/inference/resmcnet/refractive-128x128x128.yaml
python model_inference.py --config-file configs/3D/inference/resmcnet/colin27.yaml
python model_inference.py --config-file configs/3D/inference/resmcnet/digimouse.yaml
python model_inference.py --config-file configs/3D/inference/resmcnet/usc195.yaml

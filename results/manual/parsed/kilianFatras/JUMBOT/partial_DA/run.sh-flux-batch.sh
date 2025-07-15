#!/bin/bash
#FLUX: --job-name=PDA_OH_UOT_all
#FLUX: --priority=16

conda activate python37
setcuda 10.2
python run_JUMBOT.py --s 0 --t 1 --dset office_home --net ResNet50 --output reproduced_uot --gpu_id [0,1] 
python run_JUMBOT.py --s 0 --t 2 --dset office_home --net ResNet50 --output reproduced_uot --gpu_id [0,1] 
python run_JUMBOT.py --s 0 --t 3 --dset office_home --net ResNet50 --output reproduced_uot --gpu_id [0,1] 
python run_JUMBOT.py --s 1 --t 0 --dset office_home --net ResNet50 --output reproduced_uot --gpu_id [0,1] 
python run_JUMBOT.py --s 1 --t 2 --dset office_home --net ResNet50 --output reproduced_uot --gpu_id [0,1] 
python run_JUMBOT.py --s 1 --t 3 --dset office_home --net ResNet50 --output reproduced_uot --gpu_id [0,1] 
python run_JUMBOT.py --s 2 --t 0 --dset office_home --net ResNet50 --output reproduced_uot --gpu_id [0,1] 
python run_JUMBOT.py --s 2 --t 1 --dset office_home --net ResNet50 --output reproduced_uot --gpu_id [0,1] 
python run_JUMBOT.py --s 2 --t 3 --dset office_home --net ResNet50 --output reproduced_uot --gpu_id [0,1] 
python run_JUMBOT.py --s 3 --t 0 --dset office_home --net ResNet50 --output reproduced_uot --gpu_id [0,1] 
python run_JUMBOT.py --s 3 --t 1 --dset office_home --net ResNet50 --output reproduced_uot --gpu_id [0,1] 
python run_JUMBOT.py --s 3 --t 2 --dset office_home --net ResNet50 --output reproduced_uot --gpu_id [0,1] 

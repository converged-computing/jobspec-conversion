#!/bin/bash
#FLUX: --job-name=HNT-ESOL
#FLUX: -c=4
#FLUX: --queue=GPU
#FLUX: -t=172800
#FLUX: --urgency=16

python train_esol.py --seed 16880611 --pos 0
python train_esol.py --seed 17760704 --pos 0
python train_esol.py --seed 17890714 --pos 0
python train_esol.py --seed 19491001 --pos 0
python train_esol.py --seed 19900612 --pos 0
python train_esol.py --seed 16880611 --pos 1
python train_esol.py --seed 17760704 --pos 1
python train_esol.py --seed 17890714 --pos 1
python train_esol.py --seed 19491001 --pos 1
python train_esol.py --seed 19900612 --pos 1
python train_esol.py --seed 16880611 --pos 2
python train_esol.py --seed 17760704 --pos 2
python train_esol.py --seed 17890714 --pos 2
python train_esol.py --seed 19491001 --pos 2
python train_esol.py --seed 19900612 --pos 2

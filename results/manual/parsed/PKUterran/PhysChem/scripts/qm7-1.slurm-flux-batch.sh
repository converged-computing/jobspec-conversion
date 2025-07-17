#!/bin/bash
#FLUX: --job-name=QM7-1
#FLUX: -c=4
#FLUX: --queue=GPU
#FLUX: -t=432000
#FLUX: --urgency=16

python qm7.py --seed 16880611 --pos 2
python qm7.py --seed 16880611 --pos 1
python qm7.py --seed 16880611 --pos 0
python qm7.py --seed 17760704 --pos 2
python qm7.py --seed 17760704 --pos 1
python qm7.py --seed 17760704 --pos 0
python qm7.py --seed 17890714 --pos 2
python qm7.py --seed 17890714 --pos 1
python qm7.py --seed 17890714 --pos 0
python qm7.py --seed 19491001 --pos 2
python qm7.py --seed 19491001 --pos 1
python qm7.py --seed 19491001 --pos 0
python qm7.py --seed 19900612 --pos 2
python qm7.py --seed 19900612 --pos 1
python qm7.py --seed 19900612 --pos 0

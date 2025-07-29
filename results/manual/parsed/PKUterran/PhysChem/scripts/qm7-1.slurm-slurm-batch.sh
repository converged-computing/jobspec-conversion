#!/bin/bash
#SBATCH --job-name=QM7-1
#SBATCH --output=outputs/qm7-1-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --time=5-00:00:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

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

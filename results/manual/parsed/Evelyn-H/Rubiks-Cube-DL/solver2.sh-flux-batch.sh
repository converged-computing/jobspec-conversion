#!/bin/bash
#FLUX: --job-name=Solver
#FLUX: -t=43200
#FLUX: --priority=16

export PATH='$PATH:~/.local/bin'

export PATH=$PATH:~/.local/bin
module load python/3.6.0
cd ~/Rubiks-Cube-DL/
pipenv run python solver.py --env cube3x3 --cuda --plot plots/ --model saves/cube3x3-zero-goal-decay-d50-run_2145502/chpt_215000.dat --max-steps 10000 --samples 100 --max-depth 25

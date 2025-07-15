#!/bin/bash
#FLUX: --job-name=polyglot-single
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: --queue=express
#FLUX: -t=1800
#FLUX: --priority=16

set -e
source ~/.bashrc
source ~/bin/activate_conda
module load R gcc/9.2.0
conda activate /home/a.guha/.conda/envs/polyglot
PATH=/home/a.guha/scala/bin:/work/arjunguha-research-group/software/bin:$PATH
eval `/home/a.guha/repos/spack/bin/spack load --sh dmd`
let MAX_WORKERS=$SLURM_CPUS_PER_TASK-1
LUA_PATH="${PWD}/luaunit.lua"
hostname
lscpu | sed -nr '/Model name/ s/.*:\s*(.*) @ .*/\1/p'
g++ -o /tmp/arjun_a.out verification/skylake_error.cpp
python3 problem_evaluator.py --dir $1 --max-workers $MAX_WORKERS

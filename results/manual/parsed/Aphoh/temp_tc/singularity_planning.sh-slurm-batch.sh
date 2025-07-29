#!/bin/bash
#SBATCH --job-name=socialgame_train
#SBATCH --account=fc_ntugame
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00

singularity exec --nv --workdir ./tmp --bind $(pwd):$HOME library://aphoh/default/sg-k80-env:v1 sh -c './singularity_preamble.sh && ./planning_run.sh'

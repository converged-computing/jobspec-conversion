#!/bin/bash
#SBATCH --output=logs/slurm.out
#SBATCH --error=logs/slurm.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4Gb
#SBATCH --time=01:00:00

SCENARIO=$1
N_AGENTS=$2
PROBLEM_PARAMS=$3
source /opt/spack/main/env.sh
module load python
source venv/bin/activate
srun python -m polygonal_roadmaps -n_agents $N_AGENTS -index $SLURM_ARRAY_TASK_ID \
    -logfile "logs/$PLANNER$SCENARIO/$SLURM_ARRAY_TASK_ID.log" -loglevel warning -memlimit 5 -timelimit 30 \
    -planner $(ls benchmarks/planner_config) -scenario $SCENARIO -problem_parameters $PROBLEM_PARAMS

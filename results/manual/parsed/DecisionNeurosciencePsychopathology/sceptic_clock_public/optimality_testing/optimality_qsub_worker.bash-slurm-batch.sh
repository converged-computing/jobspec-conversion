#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/DecisionNeurosciencePsychopathology/sceptic_clock_public/optimality_testing/optimality_qsub_worker.bash

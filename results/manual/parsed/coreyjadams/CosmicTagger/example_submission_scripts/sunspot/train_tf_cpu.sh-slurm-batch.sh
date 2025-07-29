#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/coreyjadams/CosmicTagger/example_submission_scripts/sunspot/train_tf_cpu.sh

#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/coreyjadams/CosmicTagger/example_submission_scripts/polaris/run_ct_tf_a21_deterministic_singleNode.sh

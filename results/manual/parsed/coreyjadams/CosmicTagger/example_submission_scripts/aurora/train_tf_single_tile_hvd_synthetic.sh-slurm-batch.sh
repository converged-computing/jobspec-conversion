#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/coreyjadams/CosmicTagger/example_submission_scripts/aurora/train_tf_single_tile_hvd_synthetic.sh

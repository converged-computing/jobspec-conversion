#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/abeaucha/MouseHumanTranscriptomicSimilarity/cross_validation/Run_MultilayerPerceptron_Validation.sh

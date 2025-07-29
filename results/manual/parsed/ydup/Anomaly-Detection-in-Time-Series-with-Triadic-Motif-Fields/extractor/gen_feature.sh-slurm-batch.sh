#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ydup/Anomaly-Detection-in-Time-Series-with-Triadic-Motif-Fields/extractor/gen_feature.sh

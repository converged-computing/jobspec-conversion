#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/punyawat-jar/ML-Based-Adaptive-Cybersecurity-Incident-Detection/Code_and_model/cic/dataset/preprocess_df.sh

#!/bin/bash
#SBATCH --job-name=head
#SBATCH --output=logs/head.log
#SBATCH --error=logs/head.errors.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

source /users/lindgren/hjo721/job-scripts/conda.sh aminosgym
echo "this machine has $(nproc) cpus"
ray start --head --include-dashboard true --dashboard-host 0.0.0.0 --dashboard-port 5712 --node-ip-address=$(hostname)
python process_transcripts.py

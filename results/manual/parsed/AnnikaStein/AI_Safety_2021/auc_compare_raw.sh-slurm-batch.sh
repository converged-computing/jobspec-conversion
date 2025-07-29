#!/bin/bash
#SBATCH --job-name=0_raw_101-120
#SBATCH --account=rwth0583
#SBATCH --output=output.%J.txt
#SBATCH --mail-user=annika.stein@rwth-aachen.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=42G
#SBATCH --time=10:50:00
#SBATCH --constraint=ntasks-per-node=2

cd /home/um106329/aisafety
source ~/miniconda3/bin/activate
conda activate my-env
python3 auc_compare_raw.py "[101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120]" 0

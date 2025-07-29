#!/bin/bash
#SBATCH --job-name=regnn57
#SBATCH --account=r00206
#SBATCH --output=regnn57_%j.txt
#SBATCH --error=regnn57_%j.err
#SBATCH --mail-user=mraina@iu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=200G
#SBATCH --time=09:00:00
#SBATCH --partition=general
#SBATCH --constraint=ntasks-per-node=1

module load miniconda
source activate /N/slate/mraina/egnn/
cd /N/slate/mraina/REGNN/
python calculate_ARI.py

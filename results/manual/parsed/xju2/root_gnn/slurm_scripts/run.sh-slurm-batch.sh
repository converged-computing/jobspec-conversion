#!/bin/bash
#SBATCH --job-name=topreco_v2
#SBATCH --account=m1759
#SBATCH --output=backup/%x-%j.out
#SBATCH --mail-user=xju@lbl.gov
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=04:00:00
#SBATCH --constraint=gpu

which python
cd /global/homes/x/xju/code/root_gnn
train_top_reco configs/train_topreco_2tops_v2.yaml

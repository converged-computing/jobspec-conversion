#!/bin/bash
#SBATCH --job-name=EriII_noSFHPrior
#SBATCH --account=co_dweisz
#SBATCH --output=logs/EriII_noSFHPrior.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00
#SBATCH --qos=dweisz_savio2_normal
#SBATCH --constraint=ntasks-per-node=24

echo "Loading modules"
source activate /clusterfs/dweisz/nathan_sandford/.conda/envs/ChemEv
python /clusterfs/dweisz/nathan_sandford/github_repos/ChemWAF/scripts/EriII_noSFHPrior.py

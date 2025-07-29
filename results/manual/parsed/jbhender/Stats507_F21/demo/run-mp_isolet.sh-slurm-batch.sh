#!/bin/bash
#SBATCH --job-name=mp_isolet-gb0
#SBATCH --account=cscar
#SBATCH --output=/home/%u/logs/%x-%j-4.log
#SBATCH --mail-user=jbhender@umich.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=5GB
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1

n_procs=4
module load tensorflow
cat run-mp_isolet.sh
date
cd /home/jbhender/github/Stats507_F21/demo/
python mp_isolet.py $n_procs
date
echo "Done."

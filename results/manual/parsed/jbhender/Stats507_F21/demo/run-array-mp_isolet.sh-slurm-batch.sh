#!/bin/bash
#SBATCH --job-name=mp_isolet-gb0
#SBATCH --account=cscar
#SBATCH --output=/home/%u/logs/%x-%A-%a.log
#SBATCH --mail-user=jbhender@umich.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=5GB
#SBATCH --time=00:10:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=2,3,4

n_procs=${SLURM_ARRAY_TASK_ID}
module load tensorflow
cat run-mp_isolet.sh
date
cd /home/jbhender/github/Stats507_F21/demo/
python mp_isolet.py $n_procs
date
echo "Done."

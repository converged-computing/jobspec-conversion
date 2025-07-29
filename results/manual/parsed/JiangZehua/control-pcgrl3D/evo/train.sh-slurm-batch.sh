#!/bin/bash
#SBATCH --job-name=evopcgrl
#SBATCH --output=evo_runs/evopcg_0_%j.out
#SBATCH --mail-user=zj2086@nyu.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --mem=64GB
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1

cd /scratch/zj2086/control-pcgrl
source activate
conda activate pcgrl
start=$SECONDS
while ! python evo/evolve.py -la 0
do
    duration=$((( SECONDS - start ) / 60))
    echo "Script returned error after $duration minutes"
    if [ $duration -lt 60 ]
    then
      echo "Too soon. Something is wrong. Terminating node."
      exit 42
    else
      echo "Killing ray processes and re-launching script."
      ray stop
      pkill ray
      pkill -9 ray
      pkill python
      pkill -9 python
      start=$SECONDS
    fi
done

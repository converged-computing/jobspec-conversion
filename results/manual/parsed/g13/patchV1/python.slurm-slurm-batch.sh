#!/bin/bash
#SBATCH --job-name=surf
#SBATCH --output=log/surf_%J.out
#SBATCH --mail-user=wd554@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --mem=96GB
#SBATCH --time=10:00:00

module purge
module load gcc/10.2.0
module load cuda/11.1.74
module load boost/intel/1.74.0
module load matlab/2020b
theme=$1
date
pid=""
python LGN_surfaceGrid.py $theme &
pid+="${!} "
wait $pid
date

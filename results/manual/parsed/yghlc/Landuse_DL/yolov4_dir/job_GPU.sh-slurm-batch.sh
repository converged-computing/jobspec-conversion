#!/bin/bash
#SBATCH --job-name=yolov4
#SBATCH --output=%j.out
#SBATCH --mail-user=lingcao.huang@colorado.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

module purge
module load singularity/3.6.4
echo "== This is the scripting step! =="
./runIN_yoltv4_noconda_sing.sh
echo "== End of Job =="

#!/bin/bash
#SBATCH --account=p200009
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --time=1-00:00:00
#SBATCH --qos=default
#SBATCH --constraint=ntasks-per-node=1

algo=$1
teacher=$2
echo "Run module"
module load Singularity-CE/3.8.4
singularity instance start --nv -B /project/home/p200009/rundong:/home/rundong football.simg football
singularity exec -H /project/home/p200009/rundong:/home/rundong instance://football bash /home/rundong/football-invariant_att_com/run_football_in_singularity.sh ${algo} ${teacher}

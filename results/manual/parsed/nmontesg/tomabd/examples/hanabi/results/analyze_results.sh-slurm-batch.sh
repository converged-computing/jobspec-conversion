#!/bin/bash
#SBATCH --job-name=hanabi_runs
#SBATCH --output=/home/nmontes/logs/%x-%j.log
#SBATCH --error=/home/nmontes/logs/%x-%j.err
#SBATCH --mail-user=nmontes@iiia.csic.es
#SBATCH --mail-type=ALL
#SBATCH --nodes=4
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=20
#SBATCH --mem-per-cpu=2G
#SBATCH --time=12:00:00

spack load anaconda3@2021.05
for i in {2..5}
do
    srun -N1 -n1 --exclusive /home/nmontes/.conda/envs/hanabi/bin/python single.py $1 $i &
done
wait

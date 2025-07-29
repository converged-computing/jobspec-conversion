#!/bin/bash
#SBATCH --job-name=TIESanalysis
#SBATCH --account=pn98ve
#SBATCH --output=./%x.%j.out
#SBATCH --error=./%x.%j.err
#SBATCH --mail-user=bieniekmat@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=48
#SBATCH --chdir=./
#SBATCH --no-requeue

module load slurm_setup
module load python/3.6_intel
for D in */;
do
    cd $D
    echo "Next Dir: $D"
        python ../ddg.py > ddg.out &
    cd ..
done
wait

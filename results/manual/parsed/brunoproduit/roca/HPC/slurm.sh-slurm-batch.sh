#!/bin/bash
#SBATCH --job-name=ROCA
#SBATCH --output=roca.%j.out
#SBATCH --error=roca.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G
#SBATCH --time=01:00:00
#SBATCH --partition=testing

module load python-2.7.13
module load sage-6.1.1 
cores=4
OUTPUT=($(sage split_iteration.py $1 -j $cores))
for i in "${OUTPUT[@]}";
do 
  start=`echo $i | cut -d";" -f1`;
  stop=`echo $i | cut -d";" -f2`;
  sage optimization_hpc.py $1 $start $stop;
done

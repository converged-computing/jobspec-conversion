#!/bin/bash
#SBATCH --account=_______
#SBATCH --output=rscript.out
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100000
#SBATCH --time=02:00:00
#SBATCH --partition=_______

module load gcc/9.2.0 openmpi/3.1.6 R/4.2.1
for i in $(ls ../mapped/*.bam)
do
    f=`echo $i | awk -F"Aligned.sortedByCoord.out.bam" '{print $1}'`    
    Rscript bcr_analysis.R --sample $(basename $f)
done

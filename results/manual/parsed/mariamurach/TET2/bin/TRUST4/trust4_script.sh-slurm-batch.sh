#!/bin/bash
#SBATCH --account=_______
#SBATCH --output=mixcr_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000000
#SBATCH --time=02:00:00
#SBATCH --partition=_______
#SBATCH --array=1-21

module load java
output=bcr/output
mkdir $output
i=$(ls mapped/*.bam| awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID 'FNR == ArrayTaskID {print}')
echo $i
f=`echo $i | awk -F"Aligned.sortedByCoord.out.bam" '{print $1}'`    
run-trust4 -t 40 -f bcr/bcrtcr.fa --ref bcr/IMGT+C.fa -b $i -o $output/$(basename $f)

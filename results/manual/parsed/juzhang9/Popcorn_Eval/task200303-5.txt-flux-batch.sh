#!/bin/bash
#FLUX: --job-name=doopy-carrot-7854
#FLUX: -c=2
#FLUX: -t=7200
#FLUX: --urgency=16

export PYTHONUSERBASE='$HOME/local/python/2.7.13'

echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
module load intel/17
module load openmpi/2.0.1
module load python2
export PYTHONUSERBASE=$HOME/local/python/2.7.13
j=$1
l=$2
cd simulation$j
i=${SLURM_ARRAY_TASK_ID}
k=$(echo "$i * 50" | bc)
python /home/jxz617/src/Popcorn/popcorn/Popcorn/popcorn/__main__.py fit -v 1 --cfile ../expanel/scores3mbGE$k.txt --gen_effect --sfile1 EURsummarystat$l --sfile2 EASsummarystat$l ../expanel/results/ge3mb/simulation$j/EUR_EAS_corr$i
python /home/jxz617/src/Popcorn/popcorn/Popcorn/popcorn/__main__.py fit -v 1 --cfile ../expanel/scores3mbGI$k.txt --sfile1 EURsummarystat$l --sfile2 EASsummarystat$l ../expanel/results/gi3mb/simulation$j/EUR_EAS_corr$i

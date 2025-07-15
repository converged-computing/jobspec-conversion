#!/bin/bash
#FLUX: --job-name=bedClip
#FLUX: -t=900
#FLUX: --priority=16

module purge
module load kent/intel/20170111
val=$SLURM_ARRAY_TASK_ID
file=`sed -n ${val}p files.txt`
mv $file temp${val}.bed
bedClip temp${val}.bed /scratch/cgsb/ercan/annot/forBowtie/WS220.genome $file
rm temp${val}.bed
exit 0;

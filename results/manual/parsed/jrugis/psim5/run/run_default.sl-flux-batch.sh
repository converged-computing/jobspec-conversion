#!/bin/bash
#FLUX: --job-name=psim5
#FLUX: -n=8
#FLUX: --queue=large
#FLUX: -t=3600
#FLUX: --urgency=16

ml SUNDIALS/4.1.0-gimkl-2018b
echo $HOSTNAME
echo "task array id: $SLURM_ARRAY_TASK_ID"
job_dir=$( head -n $SLURM_ARRAY_TASK_ID dirs.txt | tail -1 )
echo $job_dir
cd $job_dir
srun --ntasks=8 psim5
rm psim5
ml Python/3.7.3-gimkl-2018b
srun --ntasks=1 python "SCRIPT_DIR/summary_plot.py"
srun --ntasks=1 python "SCRIPT_DIR/summary_plot_averages.py"

#!/bin/bash
#FLUX: --job-name=giant
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated = $SLURM_NTASKS"
source /etc/profile #commands in the file will be executed as they were executed in command line instead of in a new subshell
start=`date +%s.%N`
joutdir='/mnt/home/llin1/scratch/test'
paramfile=$joutdir/data_eta_l_params_lin.csv
i=$SLURM_ARRAY_TASK_ID
echo $i
n=$(wc -l < $paramfile)
echo $n
per_task=5
ID=data
start_num=$(( ($i-1)*$per_task ))
end_num=$(( $i*$per_task ))
if [ $end_num -gt $(( $n-1 )) ]; then
    end_num=$(( $n-1 )) #-1 since not counting the header row
fi
echo $start_num
echo $end_num
python -u jobarray.py -outdir $joutdir -startnum $start_num -endnum $end_num -paramfile $paramfile > $joutdir/$ID-$i.out & 
wait
end=`date +%s.%N`
runtime=$(echo "$end - $start" | bc -l)
seconds=$(bc <<< "scale=2; $runtime"); 
echo "Runtime: $seconds seconds"

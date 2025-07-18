#!/bin/bash
#FLUX: --job-name=test
#FLUX: -n=28
#FLUX: --queue=RM
#FLUX: -t=144000
#FLUX: --urgency=16

ID=$SLURM_ARRAY_JOB_ID
total_job=$SLURM_ARRAY_TASK_COUNT
job_id=$SLURM_ARRAY_TASK_ID
home='/verafs/scratch/phy200040p/sukhdeep/project/skylens/scripts/'
cd $home
log_file=$home'../temp/log/run_minimal.log'
touch $log_file
echo 'logfile' $log_file
echo '=============================================================='>>$log_file
echo 'begining::' $(date)>>$log_file 
./dask-vera.sh &
CSCRATCH='/verafs/scratch/phy200040p/sukhdeep/physics2/skylens/temp/'
SCHEFILE=$CSCRATCH/${SLURM_JOB_ID}/${SLURM_JOB_ID}.dasksche.json
worker_log=$CSCRATCH/${SLURM_JOB_ID}/dask-local/worker-0.log
echo $worker_log
while ! [ -f $SCHEFILE ]; do #redundant
    sleep 3
    echo -n .>>$log_file
done
while ! [ -f $worker_log ]; do
    sleep 3
    echo -n .>>$log_file
done
sleep 10
more $worker_log | cat>>$log_file
python3 minimal_3X2.py --scheduler=$SCHEFILE |cat>>$log_file
echo 'logfile' $log_file
echo 'worker log' $worker_log
echo 'Finished::' $(date)>>$log_file                                                                                                                                                                    
echo '================================================' >>$log_file          
killall python
killall pproxy
killall srun
pkill -f dask-vera.sh
mv $worker_log $CSCRATCH/${SLURM_JOB_ID}/worker-0.log.minimal

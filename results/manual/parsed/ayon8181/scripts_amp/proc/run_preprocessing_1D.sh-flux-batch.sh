#!/bin/bash
#FLUX: --job-name=proc
#FLUX: -N=20
#FLUX: --exclusive
#FLUX: --queue=normal
#FLUX: -t=1200
#FLUX: --priority=16

export gen='python ../generate_path_files.py -p ../paths.yml -s ../settings.yml -e ../event_list'
export UCX_TLS='knem,dc_x'

STARTTIME=$(date +%s)
echo "start time is : $(date +"%T")"
source ~/.bashrc
conda activate py3
export gen="python ../generate_path_files.py -p ../paths.yml -s ../settings.yml -e ../event_list"
events=`$gen list_events`
periods=`$gen list_period_bands`
nproc=56
nworkers=$SLURM_NNODES
jobfile=jobs_proc_obsd_1D_crust_${SLURM_JOBID}
rm -rf ${jobfile}
touch $jobfile
export UCX_TLS="knem,dc_x"
for e in $events
do
    for p in $periods
       do
	echo running: $i $e $p
 	echo python proc.py \
    	   -p ./parfile/proc_obsd_1D_crust.${p}.param.yml \
    	   -f ./paths/proc_obsd_1D_crust.${e}.${p}.path.json >> ${jobfile}
    done
done
../run_mpi_queue.py $nproc $nworkers ${jobfile}
ENDTIME=$(date +%s)
Ttaken=$(($ENDTIME - $STARTTIME))
echo
echo "finish time is : $(date +"%T")"
echo "RUNTIME is :  $(($Ttaken / 3600)) hours ::  $(($(($Ttaken%3600))/60)) minutes  :: $(($Ttaken % 60)) seconds."

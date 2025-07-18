#!/bin/bash
#FLUX: --job-name=wobbly-cat-4579
#FLUX: --queue=copyq
#FLUX: -t=43200
#FLUX: --urgency=16

pipeuser=PIPEUSER
source /group/mwasci/$pipeuser/GLEAM-X-pipeline/GLEAM-X-pipeline.profile
alias mwa_client='module load singularity; env PYTHONPATH= singularity exec /pawsey/mwa/singularity/manta-ray-client/manta-ray-client_latest.sif mwa_client $@'
base=BASEDIR
obslist=OBSLIST
cd ${base}
list=`cat ${obslist}_manta.tmp | awk '{print substr($1,8,10)}'`
n=1
for obsnum in $list
do
    track_task.py start --jobid=${SLURM_JOBID} --taskid=$n --start_time=`date +%s`
    ((n+=1))
done
cd ${base}
mwa_client --csv=${obslist}_manta.tmp --dir=${base}
n=1
for obsnum in $list
do
    if [[ -e ${obsnum}_ms.zip ]]
    then
        if [[ ! -d ${obsnum} ]]
        then
            mkdir $obsnum
        fi
        cd $obsnum
        if [[ -d ${obsnum}.ms ]]
        then
            echo "${obsnum}.ms already exists; please remove directory before running unzip job."
            track_task.py fail --jobid=${SLURM_JOBID} --taskid=$n --finish_time=`date +%s`
        else
            mv ../${obsnum}_ms.zip ./
            unzip ${obsnum}_ms.zip
            if [[ $? ]]
            then
                rm ${obsnum}_ms.zip
                track_task.py finish --jobid=${SLURM_JOBID} --taskid=$n --finish_time=`date +%s`
            else
                echo "Failed to unzip ${obsnum}_ms.zip"
                track_task.py fail --jobid=${SLURM_JOBID} --taskid=$n --finish_time=`date +%s`
            fi
        fi
        cd ../
    elif [[ -e ${obsnum}_vis.zip ]]
    then
        echo "${obsnum}_vis.zip downloaded successfully; now run cotter."
        track_task.py finish --jobid=${SLURM_JOBID} --taskid=$n --finish_time=`date +%s`
    else
        echo "${obsnum}_ms.zip failed to download."
        track_task.py fail --jobid=${SLURM_JOBID} --taskid=$n --finish_time=`date +%s`
    fi
    ((n+=1))
done

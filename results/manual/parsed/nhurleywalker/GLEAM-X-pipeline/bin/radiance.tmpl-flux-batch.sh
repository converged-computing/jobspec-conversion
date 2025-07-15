#!/bin/bash
#FLUX: --job-name=hanky-motorcycle-3381
#FLUX: --queue=STANDARDQ
#FLUX: -t=1380
#FLUX: --priority=16

export PYTHON_EGG_CACHE='/tmp'

pipeuser=PIPEUSER
source /group/mwasci/$pipeuser/GLEAM-X-pipeline/GLEAM-X-pipeline.profile
module load shifter
function test_fail {
if [[ $1 != 0 ]]
then
    track_task.py fail --jobid=${SLURM_JOBID} --taskid=1 --finish_time=`date +%s`
    exit $1
fi
}
obsnum=OBSNUM
base=BASEDIR
option=OPTION
track_task.py start --jobid=${SLURM_JOBID} --taskid=1 --start_time=`date +%s`
datadir=${base}/${obsnum}
cd ${datadir}
ls $datadir/${obsnum}_${option}-????-image.fits > ${obsnum}_cnn.csv
export PYTHON_EGG_CACHE=/tmp
shifter run trettelbach/pytorch_astro:latest python /group/mwasci/trettelbach/paper/cnn_gleam_inference.py "/group/mwasci/trettelbach/paper/" "${datadir}/${obsnum}_cnn.csv" 0
rfifound=0
for file in ${obsnum}_${option}-????-image.fits
do
    rfi=`pyhead.py -p RFI $file | awk '{print $3}'`
    if (( $(echo "$rfi > 0.5" | bc -l) ))
    then
        rfifound=1
    fi
done
track_task.py finish --jobid=${SLURM_JOBID} --taskid=1 --finish_time=`date +%s`
if [[ $rfifound -eq 1 ]]
then
    exit 0
else
    exit 1
fi

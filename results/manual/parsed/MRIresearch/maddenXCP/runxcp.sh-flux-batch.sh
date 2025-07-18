#!/bin/bash
#FLUX: --job-name=rpt-sub-7032_ses-1_xcpengine
#FLUX: -n=20
#FLUX: --queue=standard
#FLUX: -t=36000
#FLUX: --urgency=16

SUB=sub-7032
SES=ses-1
singloc=/xdisk/nkchen/chidi/CONTAINERS/buildOnHPC/xcpengine-madden.sif
rootdir=$PWD/xcp
mkdir -p $rootdir
mkdir -p $rootdir/work
mkdir -p $rootdir/config
fmriprepdir=$PWD/fmriprep
FMRISTUB="task-resting_run-1_space-T1w_desc-preproc_bold"
COHORTBASE=cohort_${SUB}_${SES}.csv
COHORT=${rootdir}/config/${COHORTBASE}
echo id0,id1,img > ${COHORT}
echo "${SUB},${SES},${fmriprepdir}/${SUB}/${SES}/func/${SUB}_${SES}_${FMRISTUB}.nii.gz" >> ${COHORT}
cohortfile=config/cohort_${SUB}_${SES}.csv
designfile=config/fc-36p-short.dsn
cp fc-36p-short.dsn $rootdir/$designfile
CONFOUND=${fmriprepdir}/${SUB}/${SES}/func/${SUB}_${SES}_task-resting_run-1_desc-confounds_timeseries.tsv
CONFOUND_OUT=${fmriprepdir}/${SUB}/${SES}/func/${SUB}_${SES}_task-resting_confound.backup
CONFOUND_USED=${fmriprepdir}/${SUB}/${SES}/func/${SUB}_${SES}_task-resting_confound.used
if [ -f $CONFOUND_OUT ]
then
echo "copying confound back....."
    mv $CONFOUND $CONFOUND_USED
    mv $CONFOUND_OUT $CONFOUND
fi
python modifyConfounds.py $CONFOUND --confound_out=${CONFOUND_OUT} 
bind="-B ${rootdir}/work:/work -B ${rootdir}:/data"
singularity run --cleanenv $bind $singloc \
-c /data/$cohortfile \
-d /data/$designfile \
-o /data/xcpoutput \
-i /data/work

#!/bin/bash
#FLUX: --job-name=PLEXOS
#FLUX: --queue=short
#FLUX: -t=14400
#FLUX: --priority=16

export model='`head -n $SUB_ID $SLURM_SUBMIT_DIR/$LIST | tail -1`'
export MAX_TEMP_FILE_AGE='50'
export PLEXOS_TEMP='/scratch/$USER/tmp/$JOBID'
export TEMP='$PLEXOS_TEMP'
export doh5='0'

license () {
    for attempt in `seq 5` ; do
      ping -c 2 10.60.3.188  > /dev/null
      if [ $? -eq 1 ] ; then
        date
        echo -e "Can not see license server. \nWill try again in 60 seconds.\n"
      else
        return 0
      fi
      if [ $attempt -lt 5 ]  ; then sleep 60 ; fi
    done
    date
    echo "license lookup failed - exiting"
    date                              >> license.fail
    hostname                          >> license.fail
    ping -c 2 10.60.3.188             >> license.fail
    ping -c 2 eagle-dav.hpc.nrel.gov  >> license.fail
    exit
}
license
echo "found license server"
module use -a /nopt/nrel/apps/modules/default/modulefiles
module purge
case $version in
    7.4)   # loads PLEXOS 7.4
        module load mono/4.6.2.7 xpressmp/8.0.4 centos plexos/7.400.2
        ;;
    8.1)   # loads PLEXOS 8.1
        module load centos mono xpressmp/8.5.6 plexos/8.100R02
        ;;
    *)     # default to PLEXOS 8.2
        module load centos mono/6.8.0.105 xpressmp/8.5.6 plexos/8.200R01
        version=8.2
        ;;
esac
echo 'I am in ' $PWD ' submitting for PLEXOS ' $version
if [[ $SLURM_ARRAY_JOB_ID ]] ; then
 export JOB_ID=$SLURM_ARRAY_JOB_ID
 export SUB_ID=$SLURM_ARRAY_TASK_ID
else
 export JOB_ID=$SLURM_JOB_ID
 export SUB_ID=1
fi
mkdir -p $JOB_ID
cd $JOB_ID
if [ -z ${LIST+x} ]; then echo "LIST is unset"; export LIST=in_list ; else echo "LIST is set to '$LIST'"; fi
export model=`head -n $SUB_ID $SLURM_SUBMIT_DIR/$LIST | tail -1`
mkdir -p $model
cd $model
cat $0 > myscript
printenv > variables
export MAX_TEMP_FILE_AGE=50
export PLEXOS_TEMP=/scratch/$USER/tmp/$JOBID
export TEMP=$PLEXOS_TEMP
mkdir -p $PLEXOS_TEMP $TEMP
ln -fs $SLURM_SUBMIT_DIR/${filename}.xml .
ln -fs $SLURM_SUBMIT_DIR/data .
plexos_command="mono $PLEXOS/PLEXOS64.exe -n "${filename}.xml" -m "${model}""
echo $plexos_command
$plexos_command
cd ../..
mkdir -p ${filename}_solutions
echo 'Moving zip files'
mv "${JOB_ID}/${model}/Model ${model} Solution/Model ${model} Solution.zip"  "${filename}_solutions/Model ${model} Solution.zip"
export doh5=0
if [ "$doh5" == 1 ] && [ -a runH5.jl ]  ;then
  echo "Running h5plexos"
  module use /home/gstephen/apps/modules
  module load julia
  julia runH5.jl ${filename}_solutions ${model}
else
  echo "Skipping  h5plexos"
fi
cp $SLURM_SUBMIT_DIR/${SLURM_JOB_ID}.* ${JOB_ID}/${model}

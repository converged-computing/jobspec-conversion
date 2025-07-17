#!/bin/bash
#FLUX: --job-name=quirky-egg-7150
#FLUX: -n=4
#FLUX: --queue=copyq
#FLUX: -t=129600
#FLUX: --urgency=16

export CRAFT='/home/ban115/craft/craft/'
export OMP_NUM_THREADS='24'

export CRAFT=/home/ban115/craft/craft/
export OMP_NUM_THREADS=24
module unload PrgEnv-cray > /dev/null
module unload gcc/4.9.0
module load python/2.7.10 > /dev/null
echo `date` starting archiveSB with $@
CRAFTDATA=/scratch2/askap/askapops/craft/co/
OUTDIR=askap-craft/co
logfile=/group/askap/ban115/craft/archive-logfiles/archived_sbs.txt
for f in $@ ; do
    f=`basename $f`
    echo "ARCHIVING $f"
    dout=$CRAFTDATA/$f
    if [[ ! -d $dout ]]  ; then
	echo "Couldnt archive $dout. Skipping.."
	continue
    fi
    pshell "cd $OUTDIR && import $dout"
    pshellerr=$?
    echo "PSHELL returned exit status: $pshellerr uploading $f"
    if [[ $pshellerr == 0 ]] ;  then
	echo "PSHELL finished successfully - deleting filterbanks"
	echo $f >> $logfile
	#echo find $dout -name '*.fil' -print0 | xargs -0 munlink
	#echo "Delete completed"
    else
	echo "PSHELL Failed with error code $pshellerr. Quitting"
	exit $pshellerr
    fi
done
echo `date` finished archiveSB

#!/bin/bash
#FLUX: --job-name=buttery-peas-5946
#FLUX: -n=4
#FLUX: --queue=copyq
#FLUX: -t=129600
#FLUX: --urgency=16

export CRAFT='/home/ban115/craft/craft/'

export CRAFT=/home/ban115/craft/craft/
NTASKS=$SLURM_TASKS_PER_NODE
module unload gcc/4.9.0
echo `date` starting archivescan with $@
CRAFTDATA=/scratch2/askap/askapops/craft/co/
OUTDIR=askap-craft/co
logfile=/group/askap/ban115/craft/archive/archived_scans.txt
tempdir=/group/askap/ban115/craft/archive/tartemp/
if [[ ! -d $tempdir ]] ; then
    mkdir -p $tempdir
fi
for f in $@ ; do
    f=`basename $f`
    echo "ARCHIVING $f"
    sbdir=$CRAFTDATA/$f
    if [[ ! -d $sbdir ]] ; then
	echo "$sbdir is not a directory. Skipping.."
	continue
    fi
    cd $sbdir
    tarname=contents.tar
    #make SBDIR name in mediaflux
    pshell "mkdir $OUTDIR/$f"
    pshellerr=$?
    if [[ $pshellerr != 0 ]] ; then
	echo "PSHELL couldn't create directory $OUTDIR/$f. Probably already exisits. Will muscle on"
    fi
    for scandir in 2*/ ; do
	if [[ ! -d $scandir ]] ;  then
	    echo $scandir not a directory. Continuing
	    continue
	fi
	pushd $scandir
	isfinished=`grep $f/$scandir $logfile`
	echo "FINISHED file contains $isfinished"
	if [[ $isfinished != '' ]] ; then
	    echo $f/$scandir was imported on $isfinished. Continuing
	    popd
	    continue
	fi
	# run all the tar jobs in the background
	pids=""
	for antdir in */*/ ; do
	    antpath="${f}/${scandir}/${antdir}"
	    temppath="${tempdir}/${antpath}"
	    mkdir -p $temppath
	    tarfile="${temppath}/${tarname}"
	    metafile=`ls $antdir/*00.fil.meta`
	    if [[ -f $metafile ]] ; then
		echo "Copying metafile $metafile"
		cp $metafile ${tarfile}.meta
	    fi
	    if [[ -f $tarfile ]] ; then
		echo Tarfile $tarfile exists. Continuing
		continue
	    fi
	    echo "Taring $antdir to $tarfile"
	    pushd $antdir
	    tar -cf $tarfile . &
	    tarpid=$!
	    popd
	    echo "Taring of $antdir to $tarfile has pid $tarpid"
	    pids+=" $tarpid"
	done
	# Wait for tar processes to finish
	for p in $pids ; do
	    wait $p
	    tarerr=$?
	    if [[ $tarerr == 0 ]] ; then
		echo "Tar pid $p finished successfully"
	    else
		echo "Tar pid $p failed with exit code $tarerr. Quitting"
		exit $tarerr
	    fi
	done
	popd
	for retry in {1..5} ; do
	    echo "Importing $scandir to $OUTDIR/$f retry $retry"
	    pshell "cd $OUTDIR/$f && import $tempdir/$f/$scandir"
	    pshellerr=$?
	    if [[ $pshellerr == 0 ]] ; then
		echo "Import successfull on retry $retry"
		break
	    else
		echo "Import failed with error $pshellerr on retry $retry. Trying again"
	    fi
	done
	if [[ $pshellerr == 0 ]] ; then
	    echo $f/$scandir `date` >> $logfile
	    echo "Deleting teporary files from $tempdir/$f/$scandir"
	    find $tempdir/$f/$scandir -name $tarname  -delete
	    delerr=$?
	    if [[ $delerr != 0 ]] ; then
		echo "Could not delete temp files in $scandir. Error code $delerr Continuing"
	    fi
	else
	    echo "PSHELL Import of $scandir failed with error $pshellerr. Quitting"
	    exit $pshellerr
	fi
    done	
done
echo `date` finished archiveSB

#!/bin/bash
#FLUX: --job-name=proc_wrf
#FLUX: --queue=savio
#FLUX: -t=86400
#FLUX: --priority=16

export WRFPROCMODE='$mode'
export JLL_WRFSCRIPT_DIR='$scriptdir'

while [[ $# > 0 ]]
do
keyin="$1"
key=$(echo $keyin | awk '{print tolower($0)}')
    case $key in
        'monthly'|'daily'|'hourly')
        mode=$key
        shift # shift the input arguments left by one
        ;;
        'behr'|'emis'|'tempo'|'avg')
        varsout=$key
        shift
        ;;
        *) # catch unrecognized arguments
        echo "The argument \"$key\" is not recognized"
        exit 1
        ;;
    esac
done
if [[ $mode == '' ]]
then
    mode='hourly'
fi
if [[ $varsout == '' ]]
then
    varsout='behr'
fi
export WRFPROCMODE=$mode
scriptdir='/global/home/users/laughner/MATLAB/BEHR/WRF_Utils'
export JLL_WRFSCRIPT_DIR=$scriptdir
nprocs=20
nthreads=4
nthreadsM1=`expr $nthreads - 1`     # just nthreads minus 1
procskip=`expr $nprocs / $nthreads` # number of processors to skip
jj=0                                # parallel thread counter
if [[ $mode != 'daily' && $mode != 'monthly' && $mode != 'hourly' ]]
then
    echo "Input must be 'daily' or 'monthly'"
    exit 1
else
    echo "mode set to $mode"
    export WRFPROCMODE=$mode # export so we can use it in the save filename
fi
dates=''
olddate=''
for file in ./wrfout*
do
    # Handle wrfout and wrfout_subset files
    dtmp=$(awk -v a="$file" -v b="d01" 'BEGIN{print index(a,b)}')
    dstart=$((dtmp+3))
    if [[ $mode == 'monthly' ]]
    then
        newdate=${file:$dstart:7}
    else
        newdate=${file:$dstart:10}
    fi
    if [[ $olddate != $newdate ]]
    then
        dates=$(echo $dates $newdate)
    fi
    olddate=$newdate
done
jobwaiting=0
rm wrf_srun_mpc.conf
for day in $dates
do
    echo ""
    echo "Files on $day"
    echo ""
    # WRF file names include output time in UTC. We'll look for the output
    # in the range of UTC times when OMI will be passing over North America
    # for this day
    # If there are no files for this day or month, then it will try to iterate
    # over the wildcard patterns themselves. Since those contain *, we
    # can avoid doing anything in that case by requiring that the file
    # name does not include a *
    if [[ $varsout == 'tempo' ]]
    then
        filepattern=$(echo wrfout_d01_${day}*)
    elif [[ $mode != 'monthly' ]]
    then 
        filepattern=$(echo wrfout_d01_${day}_{18,19,20,21,22}*)
    else
        filepattern=$(echo wrfout_d01_${day}-??_{18,19,20,21,22}*)
    fi
    if [[ $filepattern != *'*'* ]]
    then
        echo "    $filepattern"
        # This operation isn't work using multiple 20-core nodes for multiple
        # files - we just want to assign say 4 files at a time to be processed
        # on one node.  Since the man page implies that using srun with the -r
        # flag will cause job steps to be run on different nodes (rather than
        # different tasks on the same node), it looks like the multiple
        # program configuration is our best option. This means that we will
        # have to create a config file for every 4 files we want to run.
        #
        # The catch here is that the multi-prog config file gets... cranky if
        # the lines are too long. So we can't pass the files to operate on to
        # read_wrf_output as individual command line arguments because that
        # will break srun. Instead, we'll list them in the "wrfproclist" files
        # and read_wrf_output should read them from there.
        inname="wrfproclist.$jj"
        echo $filepattern > $inname
        if [[ $varsout == 'behr' ]]
        then
            echo "$jj $scriptdir/read_wrf_output.sh $inname" >> wrf_srun_mpc.conf
        elif [[ $varsout == 'emis' ]]
        then
            echo "$jj $scriptdir/read_wrf_emis.sh $inname" >> wrf_srun_mpc.conf
        elif [[ $varsout == 'tempo' ]]
        then
            echo "$jj $scriptdir/read_wrf_tempo.sh $inname" >> wrf_srun_mpc.conf
        elif [[ $varsout == 'avg' ]]
        then
            echo "$jj $scriptdir/avg_wrf_output.sh $inname" >> wrf_srun_mpc.conf
        else
            echo "Error at $LINENO in slurmrun_wrf_output.sh: \"$varsout\" is not a recognized operation"
            exit 1
        fi
        jobwaiting=1        
        if [[ $jj -lt $nthreadsM1 ]]
        then
            jj=`expr $jj + 1`
        else
            # Because we're submitting all 4 jobs at once, we don't need a
            # wait statement, srun should't continue until all four job steps 
            # finish
            srun --multi-prog wrf_srun_mpc.conf
 	        cat wrf_srun_mpc.conf
            echo
            echo "Waited for $nthreads file processing scripts to finish. Launching a new batch of $nthreads scripts ..."
            echo
            # Reset for the next set of files. Reset the task counter (jj) to 0
            # Remove the existing config file. Reset jobwaiting to false so that
            # if there aren't any more files to run, we won't waste our time after
            # exiting the loop
            jj=0
            rm wrf_srun_mpc.conf
            rm wrfproclist.?
            jobwaiting=0
        fi
    fi
done
if [[ $jobwaiting -ne 0 ]]
then
    # First we need to make sure all allocated tasks have something to do
    for i in `seq $jj $nthreadsM1`
    do
        echo "$i echo 'Unused task'" >> wrf_srun_mpc.conf
    done
    srun --multi-prog wrf_srun_mpc.conf
    cat wrf_srun_mpc.conf
fi
rm *.tmpnc *.tmp *.hrnc
exit 0

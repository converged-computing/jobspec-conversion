#!/bin/bash
#FLUX: --job-name=lovable-despacito-9629
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:$CODEFOLDER'
export TMPDIR='/scratch/$USER/tmpdir_${SLURM_JOB_ID}_${SLURM_ARRAY_TASK_ID}'

echo HOME:                $HOME
echo USER:                $USER
echo SLURM_JOB_ID:        $SLURM_JOB_ID
echo SLURM_ARRAY_TASK_ID: $SLURM_ARRAY_TASK_ID
echo HOSTNAME:            $HOSTNAME
CODEFOLDER=$1       # ......./LQDM/GENSIM
ARCHTAG=$2
CMSSWDIR=$3         # Location of CMSSW for this production
TARGETFOLDERNAME=$4 # Basefolder to store files to. Still need to create sample-specific subfolder (LQM1400_DM1323232321_X93281)
JOBLIST=$5          # List of cmsRun commands
STARTTIME=$(date +%s.%N)
eval "source $VO_CMS_SW_DIR/cmsset_default.sh"
eval "export SCRAM_ARCH=$ARCHTAG"
eval "cd $CMSSWDIR/src"
eval `scramv1 runtime -sh`
export PYTHONPATH=$PYTHONPATH:$CODEFOLDER
echo $PYTHONPATH
export TMPDIR=/scratch/$USER/tmpdir_${SLURM_JOB_ID}_${SLURM_ARRAY_TASK_ID}
echo TMPDIR: $TMPDIR
mkdir -p $TMPDIR
cd $TMPDIR
echo $LD_LIBRARY_PATH
echo $PATH
echo $PYTHONPATH
TASKCMD=$(cat $JOBLIST | sed "${SLURM_ARRAY_TASK_ID}q;d")
echo $TASKCMD
TASK_FAILED=0
eval $TASKCMD || { echo "cmsRun failed. Going to delete rootfile(s)." ; rm -rf $(ls *.root) ; }
eval "ls"
eval "rm *_LHE.root"
FILENAME=$(ls *.root)
echo "creating folder: $TARGETFOLDERNAME"
MKDIRCOMMAND='LD_LIBRARY_PATH='' PYTHONPATH='' gfal-mkdir -p $TARGETFOLDERNAME; sleep 10s;'
eval "$MKDIRCOMMAND"
echo "copying file $FILENAME"
eval "LD_LIBRARY_PATH='' PYTHONPATH='' gfal-copy -f file:////$PWD/$FILENAME $TARGETFOLDERNAME"
echo "removing file $FILENAME in $PWD"
eval "rm $FILENAME"
rm -rf $TMPDIR
echo Removed TMPDIR: $TMPDIR
ENDTIME=$(date +%s.%N)
echo "Execution time:" $(date -u -d "0 $ENDTIME sec - $STARTTIME sec" +"%H:%M:%S")
echo Done.

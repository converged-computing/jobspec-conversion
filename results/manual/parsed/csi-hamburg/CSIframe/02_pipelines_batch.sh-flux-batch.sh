#!/bin/bash
#FLUX: --job-name=adorable-lentil-7441
#FLUX: --priority=16

export TEMPLATEFLOW_HOME='$BIDS_DIR/code/templateflow; 			[ ! -d $TEMPLATEFLOW_HOME ] && mkdir -p $TEMPLATEFLOW_HOME'
export SINGULARITYENV_TEMPLATEFLOW_HOME='$TEMPLATEFLOW_HOME;		[ ! -d $SINGULARITYENV_TEMPLATEFLOW_HOME ] && mkdir -p $SINGULARITYENV_TEMPLATEFLOW_HOME'
export SINGULARITY_CACHEDIR='$SCRATCH_DIR/singularity_cache; 	[ ! -d $SINGULARITY_CACHEDIR ] && mkdir -p $SINGULARITY_CACHEDIR'
export SINGULARITY_TMPDIR='$SCRATCH_DIR/singularity_tmp; 		[ ! -d $SINGULARITY_TMPDIR ] && mkdir -p $SINGULARITY_TMPDIR'
export SINGULARITYENV_FS_LICENSE='$ENV_DIR/freesurfer_license.txt'
export OMP_NTHREADS='$(($SLURM_CPUS_PER_TASK - 1 ))'
export MEM_GB='$(awk "BEGIN {print int($MEM_MB/1000); exit}")'

source /sw/batch/init.sh
start=$(date +%s)
module unload singularity
module switch singularity/3.5.2-overlayfix
module load parallel
set -x
umask u=rwx g=rwx
ulimit -c 0
set -o allexport
source $SCRIPT_DIR/environment.conf
set +o allexport
export TEMPLATEFLOW_HOME=$BIDS_DIR/code/templateflow; 			[ ! -d $TEMPLATEFLOW_HOME ] && mkdir -p $TEMPLATEFLOW_HOME
export SINGULARITYENV_TEMPLATEFLOW_HOME=$TEMPLATEFLOW_HOME;		[ ! -d $SINGULARITYENV_TEMPLATEFLOW_HOME ] && mkdir -p $SINGULARITYENV_TEMPLATEFLOW_HOME
export SINGULARITY_CACHEDIR=$SCRATCH_DIR/singularity_cache; 	[ ! -d $SINGULARITY_CACHEDIR ] && mkdir -p $SINGULARITY_CACHEDIR
export SINGULARITY_TMPDIR=$SCRATCH_DIR/singularity_tmp; 		[ ! -d $SINGULARITY_TMPDIR ] && mkdir -p $SINGULARITY_TMPDIR
export SINGULARITYENV_FS_LICENSE=$ENV_DIR/freesurfer_license.txt
if [ -z $ANALYSIS_LEVEL ];then
	echo "Specify analysis level. (subject/group)"
	read ANALYSIS_LEVEL; export ANALYSIS_LEVEL
fi
subj_batch_array=($@)
echo starting processing with $PIPELINE from index: $ITER ...
echo for n=$SUBJS_PER_NODE subjects
echo subjects to process: ${subj_batch_array[@]}
echo submission script directory: $SCRIPT_DIR
echo ITERator: $ITER
if [ "$ANALYSIS_LEVEL" == "subject" ];then
    export SLURM_CPUS_PER_TASK=$(awk "BEGIN {print int($HPC_NTHREADS/$SUBJS_PER_NODE); exit}")
    export MEM_MB=$(awk "BEGIN {print int($HPC_MEM/$SUBJS_PER_NODE); exit}")
elif [ "$ANALYSIS_LEVEL" == "group" ];then
    export SLURM_CPUS_PER_TASK=$HPC_NTHREADS
    export MEM_MB=$HPC_MEM
fi
export OMP_NTHREADS=$(($SLURM_CPUS_PER_TASK - 1 ))
export MEM_GB=$(awk "BEGIN {print int($MEM_MB/1000); exit}")
cd $PROJ_DIR
PROC_SCRIPT=$PIPELINE_DIR/${PIPELINE}${PIPELINE_SUFFIX}.sh
if [ $ANALYSIS_LEVEL == subject ];then
	parallel="parallel --ungroup --delay 0.2 -j$SUBJS_PER_NODE --joblog $CODE_DIR/log/parallel_runtask.log"
	echo -e "running:\n $parallel $proc_script {} ::: ${subj_batch_array[@]}"
	$parallel $PROC_SCRIPT ::: ${subj_batch_array[@]}
elif [ $ANALYSIS_LEVEL == group ];then
	source $PROC_SCRIPT "${subj_batch_array[@]}"
fi
df -h $SCRATCH_DIR
runtime_s=$(expr $(expr $(date +%s) - $start))
echo "script runtime: $(date -d@$runtime_s -u +%H:%M:%S) hours"

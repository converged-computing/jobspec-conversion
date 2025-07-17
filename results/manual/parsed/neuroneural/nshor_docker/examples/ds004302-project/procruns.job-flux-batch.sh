#!/bin/bash
#FLUX: --job-name=PRP4302
#FLUX: -n=4
#FLUX: -c=4
#FLUX: --queue=qTRD
#FLUX: -t=72000
#FLUX: --urgency=16

sleep 5s
module load singularity/3.10.2
SUB_PATHS_FILE=/data/users2/jwardell1/nshor_docker/ds004302-project/ds004302/paths
SIF_FILE=/data/users2/jwardell1/nshor_docker/dkrimg.sif
RUN_BIND_POINT=/run
SCRIPT_NAME=/data/users2/jwardell1/nshor_docker/pd_dockerParallelized.sh
IFS=$'\n'
paths_array=($(cat ${SUB_PATHS_FILE}))
echo "slurm array task id is $SLURM_ARRAY_TASK_ID"
func_ix=$(( 3*$SLURM_ARRAY_TASK_ID ))
anat_ix=$(( 3*$SLURM_ARRAY_TASK_ID + 1 ))
out_ix=$(( 3*$SLURM_ARRAY_TASK_ID + 2 ))
func_filepath=${paths_array[${func_ix}]}
anat_filepath=${paths_array[${anat_ix}]}
out_bind=${paths_array[${out_ix}]}
func_bind=`dirname $func_filepath`
anat_bind=`dirname $anat_filepath`
func_file=`basename $func_filepath`
anat_file=`basename $anat_filepath`
singularity exec --writable-tmpfs --bind .:$RUN_BIND_POINT,$func_bind:/func,$anat_bind:/anat,$out_bind:/out $SIF_FILE ${RUN_BIND_POINT}/${SCRIPT_NAME}  -f $func_file -a $anat_file -o $out_bind &
wait
sleep 10s

#!/bin/bash
#FLUX: --job-name=salted-despacito-6032
#FLUX: -n=2
#FLUX: --queue=test
#FLUX: -t=43200
#FLUX: --urgency=16

export SRMWORKINGDIR='$SCRATCH_DIRECTORY'

echo -e "Running script as user... $USER"
SCRATCH_DIRECTORY=/tmp/$USER/$SLURM_JOBID/
export SRMWORKINGDIR=$SCRATCH_DIRECTORY
mkdir -p $SRMWORKINGDIR
unzip -j -d $SRMWORKINGDIR *.zip 
SRMDIR=/usr/local/srm-driver/
cd $SRMDIR
numprocess=1
processpernode=1
SRM=./driver
CMD="\"$SRM\" -s -w $SRMWORKINGDIR"
echo -e "\nExecuting command:\n$CMD\n==================\n"
eval $CMD
echo
echo 'Slurm job diagnostics:'
sacct --job $SLURM_JOBID --format "JobName,Submit,Elapsed,AveCPU,CPUTime,UserCPU,TotalCPU,NodeList,NTasks,AveDiskRead,AveDiskWrite"
cd $SRMWORKINGDIR
zip -r output.zip .						
cp output.zip $SLURM_SUBMIT_DIR
cd $SLURM_SUBMIT_DIR
rm -rf $SCRATCH_DIRECTORY || exit $?

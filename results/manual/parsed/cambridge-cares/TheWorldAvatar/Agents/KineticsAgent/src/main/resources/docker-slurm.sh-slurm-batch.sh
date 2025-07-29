#!/bin/bash
#SBATCH --account=test-account
#SBATCH --output=slurm.%u.%j.%N.stdout.txt
#SBATCH --error=slurm.%u.%j.%N.errout.txt
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4096M
#SBATCH --time=12:00:00

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

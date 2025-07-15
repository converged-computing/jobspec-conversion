#!/bin/bash
#FLUX: --job-name=QR-so_STAR
#FLUX: --queue=scb
#FLUX: -t=86400
#FLUX: --priority=16

echo "`date`: Beginning job execution..."
RUN=runSim_v2.java
runname=$(basename $PWD)
if [[ "$runname" != "trial"* ]]
then
runname="$(basename $(dirname $PWD))_$(basename $PWD)"
fi
sim_file="${runname}.sim"
A_C=1.3                 #Lateral acceleration [G's], only for cornering
V=16.0                  #Straight Line speed for half-car [m/s], only for straight-line
sed -i "/A_C =/c\    public static double A_C = $A_C;" $RUN
sed -i "/V =/c\    public static double V = $V;" $RUN
echo "----------------------------------------------------"
echo "This job is allocated to run on $SLURM_NTASKS cpu(s)"
echo "Job is running on node(s): "
echo "$SLURM_JOB_NODELIST"
echo "----------------------------------------------------"
echo "Beginning steady run..."
RUNSTART=`date +%s`
$starccm+ -rsh ssh -batchsystem slurm $sim_file -doepower -np $SLURM_NTASKS -batch $RUN
RUNEND=`date +%s`
echo "Steady run finished"
echo "Time elapsed: $(($RUNEND - $RUNSTART)) seconds to run"
echo ""
rm -f "${runname}.sim~"
echo "`date`: Job has finished running"

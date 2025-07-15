#!/bin/bash
#FLUX: --job-name=misunderstood-malarkey-9390
#FLUX: -n=8
#FLUX: --queue=gpu2
#FLUX: -t=172800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

ulimit -s unlimited
echo Starting Program
module purge                                 # purge if you already have modules loaded
module load modenv/scs5
module load Python/3.6.4-intel-2018a
. /home/medranos/vdftb20/bin/activate
echo "training starts"
walltime=$(squeue -h -j $SLURM_JOBID -o "%L")
IFS=- read daysleft rest <<< "$walltime"
if [ -z "$rest" -a "$rest" != " " ]; then
    rest=$daysleft
    daysleft=0
fi
IFS=: read hsleft minsleft secsleft <<< "$rest"
hslefttot=$(($daysleft*24 + $hsleft))
walltime1=$(date -u -d "$rest" +"%H:%M:%S")
walltime2=$daysleft" days "$(date -u -d "$rest" +"%H hours %M minutes %S seconds")
echo "*** JOB '"$SLURM_JOB_NAME"' (ID: "$SLURM_JOBID") ***"
echo "*** "$SLURM_NODELIST": "$SLURM_JOB_NUM_NODES" node(s),  "$SLURM_NTASKS" core(s) in total ***"
echo "*** Submitted in: ${SLURM_SUBMIT_DIR} ***"
echo ""
echo "*** [TIMING] start "$(date "+%b %d, %H:%M:%S")" ***"
echo "*** [TIMING] walltime "$walltime" ["$hslefttot":"$minsleft":"$secsleft"] ends "$(date -d "$walltime2" "+%b %d, %H:%M:%S")" ***"
echo ""
echo ""
export OMP_NUM_THREADS=1
echo ""
echo "JOB OUTPUT:"
echo "###########################################################################"
echo ""
SECONDS=0
work=/scratch/ws/1/medranos-DFTB/raghav/code
git add .
git commit -m 'Server results for conv2,normalize, standardize'
git pull origin master
sbatch mod2.sh
EXTSTAT=$?
echo ""
echo "###########################################################################"
echo ""
echo "*** [TIMING] end "$(date "+%b %d, %H:%M:%S")" ***"
echo "*** [TIMING] duration "$(squeue -h -j $SLURM_JOBID -o "%M")"["$(($SECONDS/3600))":"$(TZ=UTC0 printf '%(%M:%S)T\n' $SECONDS)"] ***"
echo ""
exit $EXTSTAT

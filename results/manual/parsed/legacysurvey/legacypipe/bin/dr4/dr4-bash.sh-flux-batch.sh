#!/bin/bash
#FLUX: --job-name=dr4-bash
#FLUX: --queue=debug
#FLUX: -t=600
#FLUX: --urgency=16

export MKL_NUM_THREADS='1'
export OMP_NUM_THREADS='$threads'

set -x
export MKL_NUM_THREADS=1
ulimit -a
bri="$(echo $brick | head -c 3)"
log="$outdir/logs/$bri/$brick/log.$SLURM_JOBID"
mkdir -p $(dirname $log)
echo Logging to: $log
echo Running on ${NERSC_HOST} $(hostname)
echo -e "\n\n\n" >> $log
echo "-----------------------------------------------------------------------------------------" >> $log
echo "PWD: $(pwd)" >> $log
echo "Modules:" >> $log
module list >> $log 2>&1
echo >> $log
echo "Environment:" >> $log
set | grep -v PASS >> $log
echo >> $log
ulimit -a >> $log
echo >> $log
echo -e "\nStarting on ${NERSC_HOST} $(hostname)\n" >> $log
echo "-----------------------------------------------------------------------------------------" >> $log
threads=32
export OMP_NUM_THREADS=$threads
echo outdir="$outdir", brick="$brick"
srun -n 1 -c $OMP_NUM_THREADS python legacypipe/runbrick.py \
     --run dr4 \
     --brick $brick \
     --skip \
     --threads $OMP_NUM_THREADS \
     --checkpoint $outdir/checkpoints/${bri}/${brick}.pickle \
     --pickle "$outdir/pickles/${bri}/runbrick-%(brick)s-%%(stage)s.pickle" \
     --outdir $outdir --nsigma 6 \
     --force-all \
     --zoom 1400 1600 1400 1600
     >> $log 2>&1
rm $statdir/inq_$brick.txt
echo $run_name DONE $SLURM_JOBID

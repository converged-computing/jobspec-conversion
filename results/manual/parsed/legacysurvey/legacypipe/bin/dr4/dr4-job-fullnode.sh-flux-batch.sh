#!/bin/bash
#FLUX: --job-name=OneNode
#FLUX: -N=2
#FLUX: --queue=debug
#FLUX: -t=300
#FLUX: --urgency=16

export outdir='/scratch1/scratchdirs/desiproc/DRs/data-releases/dr4'
export statdir='${outdir}/progress'
export MKL_NUM_THREADS='1'
export PYTHONPATH='$CODE_DIR/legacypipe/py:${PYTHONPATH}'
export OMP_NUM_THREADS='$threads'

usecores=6
threads=$usecores
mpijobs=2
maxmem=65000000
let usemem=${maxmem}*${usecores}/24
ulimit -S -v $usemem
ulimit -a
echo usecores=$usecores
echo threads=$threads
echo mpijobs=$mpijobs
bricklist=${LEGACY_SURVEY_DIR}/bricks-dr4.txt
echo bricklist=$bricklist
if [ ! -e "$bricklist" ]; then
    echo file=$bricklist does not exist, quitting
    exit 999
fi
export outdir=/scratch1/scratchdirs/desiproc/DRs/data-releases/dr4
export statdir="${outdir}/progress"
mkdir -p $statdir $outdir
export MKL_NUM_THREADS=1
qdo_table=dr4v2
export PYTHONPATH=$CODE_DIR/legacypipe/py:${PYTHONPATH}
cd $CODE_DIR/legacypipe/py
export OMP_NUM_THREADS=$threads
echo initializing PIDs
for cnt in `seq 1 ${mpijobs}`;do
    declare pid_${cnt}=blahblah 
    pid=pid_${cnt}
    echo cnt=$cnt, pid=${!pid}
done
for i in `seq 1 1440`;do
    for cnt in `seq 1 ${mpijobs}`;do
        set -x 
        # Which pid is this?
        pid=pid_${cnt}
        # Check if pid is running
        running=`ps |grep ${!pid} |wc -c`
        if [ "$running" -gt 0 ]; then
            # It is running
            echo Waiting: pid_${cnt}=${!pid} running
        else
            set +x
            # srun a brick
            echo New srun for: pid_${cnt}=${!pid}
            # Get a brick to run
            date
            echo GETTING BRICK
            # Start at random line, avoids running same brick
            lns=`wc -l $bricklist |awk '{print $1}'`
            rand=`echo $((1 + RANDOM % $lns))`
            # Loop over bricklist, <<< so we don't loose variables in the subprocesses
            gotbrick=0
            while read aline; do
                brick=`echo $aline|awk '{print $1}'`
                whyrun=`echo $aline|awk '{print $2}'`
                bri=$(echo $brick | head -c 3)
                tractor_fits=$outdir/tractor/$bri/tractor-$brick.fits
                if [ -e "$tractor_fits" ]; then
                    continue
                elif [ -e "$statdir/inq_$brick.txt" ]; then
                    continue
                else
                    gotbrick=1
                    # Found a brick to run
                    touch $statdir/inq_$brick.txt
                    break
                fi
            done <<< "$(sed -n ${rand},${lns}p $bricklist)"
            if [ "$gotbrick" -eq 0 ]; then
                echo Never found a brick, exiting
                exit
            fi
            echo FOUND BRICK
            date
            set -x
            log="$outdir/logs/$bri/log.${brick}_${SLURM_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
            mkdir -p $(dirname $log)
            echo Logging to: $log
            echo "-----------------------------------------------------------------------------------------" >> $log
            # Print why running this brick
            echo Running b/c: $whyrun
            echo doing srun
            date
            # Run and store process ID
            srun -n 1 -N 1 -c $usecores python legacypipe/runbrick.py \
                 --run $qdo_table \
                 --brick $brick \
                 --hybrid-psf \
                 --skip \
                 --threads $OMP_NUM_THREADS \
                 --checkpoint $outdir/checkpoints/${bri}/${brick}.pickle \
                 --pickle "$outdir/pickles/${bri}/runbrick-%(brick)s-%%(stage)s.pickle" \
                 --outdir $outdir --nsigma 6 \
                 --no-write \
                 >> $log 2>&1 &
            # KEY LOGIC: Store PID so know when it is running or done
            declare pid_${cnt}=$!
            pid=pid_${cnt}
            echo cnt=$cnt, pid=${!pid}
            set +x 
        fi
    # End loop over usecores / checking if need launch srun
    done
    sleep 60
done 
echo dr4 DONE 

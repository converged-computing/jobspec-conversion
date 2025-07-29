#!/bin/bash
#FLUX: --job-name=OBILRG
#FLUX: -n=8
#FLUX: --queue=shared
#FLUX: -t=600
#FLUX: --urgency=16

export runwhat='lrg'
export outdir='$DECALS_SIM_DIR'
export PYTHONPATH='$CODE_DIR/legacypipe/py:${PYTHONPATH}'
export statdir='${outdir}/progress'
export OMP_NUM_THREADS='$threads'
export MKL_NUM_THREADS='1'

export runwhat=lrg
if [ "$runwhat" = "star" ]; then
    export nobj=500
elif [ "$runwhat" = "qso" ]; then
    export nobj=500
elif [ "$runwhat" = "elg" ]; then
    export nobj=100
elif [ "$runwhat" = "lrg" ]; then
    export nobj=100
else
    echo runwhat=$runwhat not supported
    exit
fi
usecores=4
threads=$usecores
if [ "$NERSC_HOST" = "edison" ]; then
    # 62 GB / Edison node = 65000000 kbytes
    maxmem=65000000
    let usemem=${maxmem}*${usecores}/24
else
    # 128 GB / Edison node = 65000000 kbytes
    maxmem=134000000
    let usemem=${maxmem}*${usecores}/32
fi
ulimit -S -v $usemem
ulimit -a
echo usecores=$usecores
echo threads=$threads
export outdir=$DECALS_SIM_DIR
export PYTHONPATH=$CODE_DIR/legacypipe/py:${PYTHONPATH}
cd $CODE_DIR/legacypipe/py
export statdir="${outdir}/progress"
mkdir -p $statdir $outdir
export OMP_NUM_THREADS=$threads
export MKL_NUM_THREADS=1
while true; do
    echo GETTING BRICK
    date
    bricklist=${LEGACY_SURVEY_DIR}/eboss-ngc-load-${runwhat}-${NERSC_HOST}.txt
    if [ ! -e "$bricklist" ]; then
        echo file=$bricklist does not exist, quitting
        exit 999
    fi
    # Start at random line, avoids running same brick
    lns=`wc -l $bricklist |awk '{print $1}'`
    rand=`echo $((1 + RANDOM % $lns))`
    # Use <<< to prevent loop from being subprocess where variables get lost
    while read aline; do
        objtype=`echo $aline|awk '{print $1}'`
        brick=`echo $aline|awk '{print $2}'`
        rowstart=`echo $aline|awk '{print $3}'`
        # Check whether to skip it
        bri=$(echo $brick | head -c 3)
        tractor_fits="${outdir}/${objtype}/${bri}/${brick}/rowstart${rowstart}/tractor-${objtype}-${brick}-rowstart${rowstart}.fits"
        exceed_rows="${outdir}/${objtype}/${bri}/${brick}/rowstart${rowstart}_exceeded.txt"
        inq=$statdir/inq_${objtype}_${brick}_${rowstart}.txt
        if [ -e "$tractor_fits" ]; then
            continue
        elif [ -e "$exceed_rows" ]; then
            continue
        elif [ -e "$inq" ]; then
            continue
        else
            # Found something to run
            #export objtype="$objtype"
            #export brick="$brick"
            #export rowstart="$rowstart"
            touch $inq
            break
        fi
    done <<< "$(sed -n ${rand},${lns}p $bricklist)"
    echo FOUND BRICK: $inq
    date
    ################
    #export outdir=/scratch1/scratchdirs/desiproc/DRs/data-releases/dr4-bootes/90primeTPV_mzlsv2thruMarch19/wisepsf
    #qdo_table=dr4-bootes
    set -x
    log="$outdir/$objtype/$bri/$brick/logs/log.rowst${rowstart}_${SLURM_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
    mkdir -p $(dirname $log)
    echo Logging to: $log
    echo "-----------------------------------------------------------------------------------------" >> $log
    #module load psfex-hpcp
    export therun=eboss-ngc
    export prefix=eboss_ngc
    date
    srun -n 1 -c $usecores python obiwan/decals_sim.py \
        --run $therun --objtype $objtype --brick $brick --rowstart $rowstart \
        --nobj $nobj \
        --add_sim_noise --prefix $prefix --threads $OMP_NUM_THREADS \
        >> $log 2>&1 &
    wait
    date
    rm ${inq}
    set +x
done
echo obiwan-${runwhat} DONE 

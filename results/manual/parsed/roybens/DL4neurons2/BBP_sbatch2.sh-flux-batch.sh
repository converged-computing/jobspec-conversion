#!/bin/bash
#FLUX: --job-name=DL4N_full_prod
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export THREADS_PER_NODE='1'
export HDF5_USE_FILE_LOCKING='FALSE'
export stimname1='chaotic3'
export stimname2='step_200'
export stimname3='ramp'
export stimname4='chirp'
export stimname5='step_500'

export OMP_NUM_THREADS=1
module unload craype-hugepages2M
OUT_DIR=/global/cscratch1/sd/roybens/bbpexcv3/wrk/
CELLS_FILE='excitatorycells.csv'
START_CELL=0
NCELLS=1
END_CELL=$((${START_CELL}+${NCELLS}))
NSAMPLES=1
NRUNS=1
NSAMPLES_PER_RUN=$(($NSAMPLES/$NRUNS))
echo "CELLS_FILE" ${CELLS_FILE}
echo "START_CELL" ${START_CELL}
echo "NCELLS" ${NCELLS}
echo "END_CELL" ${END_CELL}
export THREADS_PER_NODE=1
export HDF5_USE_FILE_LOCKING=FALSE
echo "Making outdirs at" `date`
arrIdx=${SLURM_ARRAY_TASK_ID}
jobId=${SLURM_ARRAY_JOB_ID}_${arrIdx}
RUNDIR=${OUT_DIR}/runs2/${jobId}
mkdir -p $RUNDIR
for i in $(seq $((${START_CELL}+1)) ${END_CELL});
do
    line=$(head -$i ${CELLS_FILE} | tail -1)
    bbp_name=$(echo $line | awk -F "," '{print $1}')
    for k in {1..1}
    do
        mkdir -p $RUNDIR/$bbp_name/c${k}
        chmod a+rx $RUNDIR/$bbp_name/c${k}
    done
done
cp BBP_sbatch2.sh $RUNDIR
chmod a+rx $RUNDIR
chmod a+rx $RUNDIR/*
echo done
date
echo "Done making outdirs at" `date`
export stimname1=chaotic3
export stimname2=step_200
export stimname3=ramp
export stimname4=chirp
export stimname5=step_500
stimfile1=stims/${stimname1}.csv
stimfile2=stims/${stimname2}.csv
stimfile3=stims/${stimname3}.csv
stimfile4=stims/${stimname4}.csv
stimfile5=stims/${stimname5}.csv
echo
env | grep SLURM
echo
FILENAME=\{BBP_NAME\}-v3
echo "STIM FILE" $stimfile
echo "SLURM_NODEID" ${SLURM_NODEID}
echo "SLURM_PROCID" ${SLURM_PROCID}
REMOTE_CELLS_FILE='/tmp/excitatorycells.csv'
REMOTE_CELLS_FILE=${CELLS_FILE}
echo REMOTE_CELLS_FILE $REMOTE_CELLS_FILE
for j in $(seq 1 ${NRUNS});
do
    echo "Doing run $j of $NRUNS at" `date`
    for l in {0..0}
    do
        adjustedval=$((l+1))
        METADATA_FILE=$RUNDIR/${FILENAME}-meta-${adjustedval}.yaml $ remove-it
        OUTFILE=$RUNDIR/\{BBP_NAME\}/c${adjustedval}/${FILENAME}-\{NODEID\}-$j-c${adjustedval}.h5
        args="--outfile $OUTFILE --stim-file ${stimfile1} ${stimfile2} ${stimfile3} ${stimfile4} ${stimfile5} --model BBP --cell-i ${l} \
          --cori-csv ${REMOTE_CELLS_FILE} --cori-start ${START_CELL} --cori-end ${END_CELL} \
          --num ${NSAMPLES_PER_RUN} --trivial-parallel --print-every 8 --linear-params-inds 12 17 18\
          --metadata-file ${METADATA_FILE} --stim-noise --dt 0.1"
        echo "args" $args
        srun --input none -k -n $((${SLURM_NNODES}*${THREADS_PER_NODE})) --ntasks-per-node ${THREADS_PER_NODE} shifter python3 -u  run.py $args
        chmod a+r $OUTFILE
    done
    echo "Done run $j of $NRUNS at" `date`
done

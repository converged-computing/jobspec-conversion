#!/bin/bash
#FLUX: --job-name=DL4N_full_prod
#FLUX: -N=64
#FLUX: --queue=flex
#FLUX: -t=7800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export THREADS_PER_NODE='128'
export PYTHONPATH='/global/cscratch1/sd/adisaran/neuronBBP_build2/nrn/lib/python/'
export stimname='chaotic_2'

export OMP_NUM_THREADS=1
module unload craype-hugepages2M
WORKING_DIR=/global/cscratch1/sd/adisaran/DL4neurons
cd $WORKING_DIR
CELLS_FILE='excitatorycells_first7.csv'
START_CELL=0
NCELLS=7
END_CELL=$((${START_CELL}+${NCELLS}))
NSAMPLES=8
NRUNS=1
NSAMPLES_PER_RUN=$(($NSAMPLES/$NRUNS))
echo "CELLS_FILE" ${CELLS_FILE}
echo "START_CELL" ${START_CELL}
echo "NCELLS" ${NCELLS}
echo "END_CELL" ${END_CELL}
export THREADS_PER_NODE=128
if [ -f ./shifter_env.sh ]; then
    source ./shifter_env.sh
    PYTHON="shifter python3"
else
    PYTHON=python
fi
export PYTHONPATH=/global/cscratch1/sd/adisaran/neuronBBP_build2/nrn/lib/python/
echo "Making outdirs at" `date`
arrIdx=${SLURM_ARRAY_TASK_ID}
jobId=${SLURM_ARRAY_JOB_ID}_${arrIdx}
RUNDIR=runs2/${jobId}
mkdir -p $RUNDIR
for i in $(seq $((${START_CELL}+1)) ${END_CELL});
do
    line=$(head -$i ${CELLS_FILE} | tail -1)
    bbp_name=$(echo $line | awk -F "," '{print $1}')
    for k in {1..5}
    do
        mkdir -p $RUNDIR/$bbp_name/c${k}
        chmod a+rx $RUNDIR/$bbp_name/c${k}
    done
done
cp BBP_sbatch3.sh $RUNDIR
chmod a+rx $RUNDIR
chmod a+rx $RUNDIR/*
echo done
date
echo "Done making outdirs at" `date`
export stimname=chaotic_2
stimfile=stims/${stimname}.csv
echo
env | grep SLURM
echo
echo "Using" $PYTHON
FILENAME=\{BBP_NAME\}-${stimname}
echo "STIM FILE" $stimfile
echo "SLURM_NODEID" ${SLURM_NODEID}
echo "SLURM_PROCID" ${SLURM_PROCID}
REMOTE_CELLS_FILE='/tmp/excitatorycells.csv'
sbcast ${CELLS_FILE} ${REMOTE_CELLS_FILE}
for j in $(seq 1 ${NRUNS});
do
    echo "Doing run $j of $NRUNS at" `date`
    for l in {0..4}
    do
        adjustedval=$((l+1))
        METADATA_FILE=$RUNDIR/${FILENAME}-meta-${adjustedval}.yaml
        OUTFILE=${WORKING_DIR}/$RUNDIR/\{BBP_NAME\}/c${adjustedval}/${FILENAME}-\{NODEID\}-$j-c${adjustedval}.h5
        args="--outfile $OUTFILE --stim-file ${stimfile} --model BBP --cell-i ${l} \
          --cori-csv ${REMOTE_CELLS_FILE} --cori-start ${START_CELL} --cori-end ${END_CELL} \
          --num ${NSAMPLES_PER_RUN} --trivial-parallel --print-every 8 \
          --metadata-file ${METADATA_FILE}"
        echo "args" $args
        srun --input none -k -n $((${SLURM_NNODES}*${THREADS_PER_NODE})) \
         --ntasks-per-node ${THREADS_PER_NODE} \
         $PYTHON run.py $args
        # Write one metadata yaml per cell
        srun -n ${NCELLS} $PYTHON run.py $args --metadata-only
    done
    chmod -R a+r $RUNDIR/*.yaml
    # run.py sets permissions on the data files themselves (doing them here simultaneously takes forever)
    echo "Done run $j of $NRUNS at" `date`
done

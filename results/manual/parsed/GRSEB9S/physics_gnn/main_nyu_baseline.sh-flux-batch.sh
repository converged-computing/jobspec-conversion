#!/bin/bash
#FLUX: --job-name=GCNN
#FLUX: -t=172800
#FLUX: --priority=16

DATASET="NYU"
NBTRAIN=100000
NBTEST=$NBTRAIN
NBBATCH=100
NBFMAP=96
NBLAYER=8
LRATE=0.005
LRDECAY=0.96
OPTIONS="--nbepoch 100 --conv_type ResGNN --node_type Identity --readout Sum --cuda"
NBEXTRANODES=30
KERNELS="QCDAwareMeanNorm"
CMBKER="Fixed_Balanced"
NBHIDDEN=4 # only applies with MLPdirected kernel
JOBNAME="qcd_""$NBEXTRANODES""_""$LRATE""_""$LRDECAY""_""$NBFMAP""_""$NBLAYER""_""$SLURM_ARRAY_TASK_ID"
NBPRINT=$((($NBTRAIN/$NBBATCH)/10))
NBPRINT=$(($NBPRINT>1?$NBPRINT:1))
PYARGS="--name $JOBNAME --kernels $KERNELS --nb_batch $NBBATCH --combine_kernels $CMBKER --data $DATASET --fm $NBFMAP --depth $NBLAYER --nb_MLPadj_hidden $NBHIDDEN --nbtrain $NBTRAIN --nbtest $NBTEST --nbprint $NBPRINT --lr $LRATE --lrdecay $LRDECAY $OPTIONS --nb_extra_nodes $NBEXTRANODES"
python3 script/main.py $PYARGS

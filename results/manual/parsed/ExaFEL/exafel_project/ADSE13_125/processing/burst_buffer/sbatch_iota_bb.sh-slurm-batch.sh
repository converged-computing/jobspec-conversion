#!/bin/bash
#FLUX: --job-name=iota_ps2cctbx
#FLUX: -N=3072
#FLUX: -t=7200
#FLUX: --urgency=16

NODES=3072
NUM_RANKS=$((NODES*68))
t_start=`date +%s`
RUN=50 #$1
TRIAL=19 #$2
RG=3 #$3
BASE_PATH=/global/cscratch1/sd/asmit/iota_demo/cxic0415
EXP=cxic0415
echo 'Processing LCLS run ' ${RUN}
RUN_DIR="r$(printf "%04d" ${RUN})"
TRIAL_RG="$(printf "%03d" ${TRIAL})_rg$(printf "%03d" ${RG})"
RG_3d="rg_$(printf "%03d" ${RG})"
mkdir $DW_JOB_STRIPED/out
sbcast -p ${BASE_PATH}/input/process_batch.phil /tmp/params_1.phil
sbcast -p ${BASE_PATH}/input/mask.pickle /tmp/mask.pickle
sbcast -p ${BASE_PATH}/input/cspad_refined_1.json /tmp/cspad_refined_1.json
sbcast -p ${BASE_PATH}/processing/command_line/xtc_process_iota_srs.py /tmp/xtc_process_iota_srs.py
t_start=`date +%s`
srun -n ${NUM_RANKS} -c 4 --cpu_bind=cores shifter ${BASE_PATH}/processing/burst_buffer/docker_xtc_process_iota_bb.sh ${RUN} ${TRIAL} ${RG} ${BASE_PATH} ${EXP} production 0
t_end=`date +%s`
echo IOTA_XTC_JobCompleted_TimeElapsed $((t_end-t_start)) $t_start $t_end ${RUN}

#!/bin/bash
#SBATCH --job-name=ps2cctbx
#SBATCH --account=m2859
#SBATCH --nodes=100
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00
#SBATCH --qos=premium
#SBATCH --constraint=knl,quad,cache

singularity
exec
registry.services.nersc.gov/asmit/iota_ps2_v2:latest
NODES=100
NUM_RANKS=$((NODES*68))
t_start=`date +%s`
RUN=50 #$1
TRIAL=18 #$2
RG=2 #$3
BASE_PATH=/global/cscratch1/sd/asmit/iota_demo/cxic0415
EXP=cxic0415
echo 'Processing LCLS run ' ${RUN}
RUN_DIR="r$(printf "%04d" ${RUN})"
TRIAL_RG="$(printf "%03d" ${TRIAL})_rg$(printf "%03d" ${RG})"
RG_3d="rg_$(printf "%03d" ${RG})"
sbcast -p ${BASE_PATH}/input/process_batch_conventional.phil /tmp/params_1.phil
sbcast -p ${BASE_PATH}/input/mask.pickle /tmp/mask.pickle
sbcast -p ${BASE_PATH}/input/cspad_refined_1.json /tmp/cspad_refined_1.json
sbcast -p ${BASE_PATH}/processing/command_line/xtc_process.py /tmp/xtc_process.py
mkdir $DW_JOB_STRIPED/out
t_start=`date +%s`
srun -n ${NUM_RANKS} -c 4 --cpu_bind=cores shifter ${BASE_PATH}/processing/burst_buffer/docker_xtc_process_bb.sh ${RUN} ${TRIAL} ${RG} ${BASE_PATH} ${EXP} production 0
t_end=`date +%s`
echo IOTA_XTC_JobCompleted_TimeElapsed $((t_end-t_start)) $t_start $t_end ${RUN}

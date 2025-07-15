#!/bin/bash
#FLUX: --job-name=crunchy-staircase-8852
#FLUX: --queue=batch,hmem
#FLUX: -t=21600
#FLUX: --priority=16

echo "------------------------"
echo "welcome to the job: ${SLURM_JOB_NAME} -> id = ${SLURM_JOB_ID}"
echo "------------------------"
HOME_MURPHY=/home/ucl/tfl/tgillis/murphy
mkdir -p ${RUN_DIR}
mkdir -p ${RUN_DIR}/data
mkdir -p ${RUN_DIR}/prof
cd ${RUN_DIR} 
cp ${HOME_MURPHY}/${MNAME} .
srun -n ${SLURM_NPROCS} \
        ./${MNAME} --sadv --profile --iter-max=500000 --iter-dump=500000 --level-min=0 --level-max=12 \
                   --ilevel=${ILEVEL} --rtol=${RTOL} --ctol=${CTOL} ${NO_ADAPT} --tfinal=3.0 ${WENO} --cfl-max=0.25 > log_$SLURM_JOB_ID.log
echo "------------------------"

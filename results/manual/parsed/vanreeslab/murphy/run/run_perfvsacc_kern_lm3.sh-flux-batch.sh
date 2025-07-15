#!/bin/bash
#FLUX: --job-name=expensive-leopard-6141
#FLUX: --queue=batch,debug
#FLUX: -t=21600
#FLUX: --urgency=16

echo "------------------------"
echo "welcome to the job: ${SLURM_JOB_NAME} -> id = ${SLURM_JOB_ID}"
echo "------------------------"
HOME_MURPHY=/home/ucl/tfl/tgillis/murphy
mkdir -p ${RUN_DIR}
mkdir -p ${RUN_DIR}/data
mkdir -p ${RUN_DIR}/prof
cd ${RUN_DIR} 
cp ${HOME_MURPHY}/${MNAME} .
MACHINEFILE="nodes.$SLURM_JOBID"
srun -l /bin/hostname | sort -n | awk '{print $2}' > $MACHINEFILE
mpirun --mca pml ucx --mca osc ucx --mca btl ^uct \
        ./${MNAME} --sadv --profile --iter-max=50000 --iter-dump=50000 --level-min=2 --level-max=9 \
                   --ilevel=${ILEVEL} --rtol=${RTOL} --ctol=${CTOL} ${NO_ADAPT} --tfinal=0.5 --weno=5 --cfl-max=1.0 > log_$SLURM_JOB_ID.log
echo "------------------------"

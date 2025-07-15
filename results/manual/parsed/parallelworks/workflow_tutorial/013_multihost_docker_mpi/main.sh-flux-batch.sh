#!/bin/bash
#FLUX: --job-name=conspicuous-leg-1015
#FLUX: --priority=16

export UCONTAINER_JOB_DIR='${PWD}'
export CLUSTER_JOB_DIR='${resource_workdir}/pw/${JOB_DIR}/'
export jobid='$(${sshcmd} sbatch ${CLUSTER_JOB_DIR}/hello-world-mpi-docker.sh | tail -1 | awk -F ' ' '{print $4}')'

APP_DIR=$(dirname $0)
source ${APP_DIR}/libs.sh
source inputs.sh
sshcmd="ssh -o StrictHostKeyChecking=no ${resource_username}@${resource_publicIp}"
echo "SSH command"
echo ${sshcmd}
JOB_DIR=$(pwd | rev | cut -d'/' -f1-2 | rev)
export UCONTAINER_JOB_DIR=${PWD}
export CLUSTER_JOB_DIR=${resource_workdir}/pw/${JOB_DIR}/
echo; echo; echo CREATING SLURM SCRIPT
sed -i "s|__CLUSTER_JOB_DIR__|${CLUSTER_JOB_DIR}|g" ${APP_DIR}/hello-world-mpi-docker.sh
sed -i "s|__OMPI_DOCKER_REPO__|${ompi_docker_repo}|g" ${APP_DIR}/hello-world-mpi-docker.sh
sed -i "s/__NODES__/${nodes}/g" ${APP_DIR}/hello-world-mpi-docker.sh
sed -i "s|__LOG_FILE__|${CLUSTER_JOB_DIR}/logs.out|g" ${APP_DIR}/hello-world-mpi-docker.sh
if [ -z "${partition}" ]; then
    sed -i '/#SBATCH --partition=__PARTITION__/d' ${APP_DIR}/hello-world-mpi-docker.sh
else
    sed -i "s/__PARTITION__/${partition}/g" ${APP_DIR}/hello-world-mpi-docker.sh
fi
echo; echo; echo TRANSFERRING NECESSARY FILES TO CLUSTER
${sshcmd} mkdir -p ${CLUSTER_JOB_DIR}
scp ${APP_DIR}/hello-world-mpi-docker.sh ${resource_username}@${resource_publicIp}:${CLUSTER_JOB_DIR}
echo; echo; echo SUBMITTING JOB
export jobid=$(${sshcmd} sbatch ${CLUSTER_JOB_DIR}/hello-world-mpi-docker.sh | tail -1 | awk -F ' ' '{print $4}')
echo "${sshcmd} sbatch ${CLUSTER_JOB_DIR}/hello-world-mpi-docker.sh"
echo "JOB ID: ${jobid}"
if [ -z "${jobid}" ]; then
    echo "ERROR: Job submission failed"
    echo "${sshcmd} sbatch ${CLUSTER_JOB_DIR}/hello-world-mpi-docker.sh"
    exit 1
fi
echo "#!/bin/bash" > cancel.sh
echo "${sshcmd} scancel ${jobid}" >> cancel.sh
chmod +x cancel.sh
jobschedulertype=SLURM
status_cmd=squeue
wait_job
./cancel.sh
echo; echo; echo PRINTING OUTPUT
${sshcmd} "cat ${CLUSTER_JOB_DIR}/mpi_hello_world.out"

#!/bin/bash
#FLUX: --job-name=crusty-lemon-0740
#FLUX: --urgency=16

export PATH='$PATH:$HOME/.local'

echo "TACC: job ${SLURM_JOB_ID} execution at: $(date)"
TAP_FUNCTIONS="/share/doc/slurm/tap_functions"
if [ -f ${TAP_FUNCTIONS} ]; then
    . ${TAP_FUNCTIONS}
else
    echo "TACC:"
    echo "TACC: ERROR - could not find TAP functions file: ${TAP_FUNCTIONS}"
    echo "TACC: ERROR - Please submit a consulting ticket at the TACC user portal"
    echo "TACC: ERROR - https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create"
    echo "TACC:"
    echo "TACC: job $SLURM_JOB_ID execution finished at: `date`"
    exit 1
fi
NODE_HOSTNAME=$(hostname -s)
echo "TACC: running on node ${NODE_HOSTNAME}"
echo "TACC: unloading xalt"
module unload xalt
echo "MNMN: install python libraries"
module load python3/3.9.2
export PATH="$PATH:$HOME/.local"
pip install --user obspy cartopy
pip uninstall -y urllib3
pip install --user 'urllib3<2.0'
echo "MNMN: load appatainer module"
module load tacc-apptainer
echo "MNMN: prepare the custom image"
SHARED_PATH="/work2/09793/mnagaso/shared_scoped_workshop"
SIF_NAME="specfem3d_globe_centos7_mpi.sif"
if [ ! -f $SIF_NAME ]; then
    if [ ! -f $SHARED_PATH/$SIF_NAME ]; then
        # load the image if no image exists in the shared directory
        echo "MNMN: pull the appatainer image"
        apptainer pull docker://ghcr.io/mnagaso/specfem3d_globe:centos7_mpi
    else
        # create symlink to the shared directory
        echo "MNMN: create symlink to the shared directory"
        ln -s $SHARED_PATH/$SIF_NAME $SIF_NAME
    fi
fi
JUPYTER_BIN=$(which jupyter-lab 2> /dev/null)
if [ -z "${JUPYTER_BIN}" ]; then
    JUPYTER_BIN=$(which jupyter-notebook 2> /dev/null)
    if [ -z "${JUPYTER_BIN}" ]; then
        echo "TACC: ERROR - could not find jupyter install"
        echo "TACC: loaded modules below"
        module list
        echo "TACC: job ${SLURM_JOB_ID} execution finished at: $(date)"
        exit 1
    else
        JUPYTER_SERVER_APP="NotebookApp"
    fi
else
    JUPYTER_SERVER_VERSION=$(${JUPYTER_BIN} --version)
    if [ ${JUPYTER_SERVER_VERSION%%.*} -lt 3 ]; then
        JUPYTER_SERVER_APP="NotebookApp"
    else
        JUPYTER_SERVER_APP="ServerApp"
    fi
fi
echo "TACC: using jupyter binary ${JUPYTER_BIN}"
if $(echo ${JUPYTER_BIN} | grep -qve '^/opt') ; then
    echo "TACC: WARNING - non-system python detected. Script may not behave as expected"
fi
NB_SERVERDIR=${HOME}/.jupyter
IP_CONFIG=${NB_SERVERDIR}/jupyter_notebook_config.py
mkdir -p ${NB_SERVERDIR}
mkdir -p ${HOME}/.tap # this should exist at this point, but just in case...
TAP_LOCKFILE=${HOME}/.tap/.${SLURM_JOB_ID}.lock
TAP_CERTFILE=${HOME}/.tap/.${SLURM_JOB_ID}
if [ ! -f ${TAP_CERTFILE} ]; then
    echo "TACC: ERROR - could not find TLS cert for secure session"
    echo "TACC: job ${SLURM_JOB_ID} execution finished at: $(date)"
    exit 1
fi
TAP_TOKEN=$(tap_get_token)
if [ -z "${TAP_TOKEN}" ]; then
    echo "TACC: ERROR - could not generate token for notebook"
    echo "TACC: job ${SLURM_JOB_ID} execution finished at: $(date)"
    exit 1
fi
echo "TACC: using token ${TAP_TOKEN}"
TAP_JUPYTER_CONFIG="${HOME}/.tap/jupyter_config.py"
if [ ${JUPYTER_SERVER_APP} == "NotebookApp" ]; then
cat <<- EOF > ${TAP_JUPYTER_CONFIG}
import ssl
c = get_config()
c.IPKernelApp.pylab = "inline"  # if you want plotting support always
c.NotebookApp.ip = "0.0.0.0"
c.NotebookApp.port = 5902
c.NotebookApp.open_browser = False
c.NotebookApp.allow_origin = u"*"
c.NotebookApp.ssl_options={"ssl_version": ssl.PROTOCOL_TLSv1_2}
c.NotebookApp.mathjax_url = u"https://cdn.mathjax.org/mathjax/latest/MathJax.js"
EOF
else
cat <<- EOF > ${TAP_JUPYTER_CONFIG}
import ssl
c = get_config()
c.IPKernelApp.pylab = "inline"  # if you want plotting support always
c.ServerApp.ip = "0.0.0.0"
c.ServerApp.port = 5902
c.ServerApp.open_browser = False
c.ServerApp.allow_origin = u"*"
c.ServerApp.ssl_options={"ssl_version": ssl.PROTOCOL_TLSv1_2}
c.NotebookApp.mathjax_url = u"https://cdn.mathjax.org/mathjax/latest/MathJax.js"
EOF
fi
JUPYTER_LOGFILE=${NB_SERVERDIR}/${NODE_HOSTNAME}.log
JUPYTER_ARGS="--certfile=$(cat ${TAP_CERTFILE}) --config=${TAP_JUPYTER_CONFIG} --${JUPYTER_SERVER_APP}.token=${TAP_TOKEN}"
echo "TACC: using jupyter command: ${JUPYTER_BIN} ${JUPYTER_ARGS}"
nohup ${JUPYTER_BIN} ${JUPYTER_ARGS} &> ${JUPYTER_LOGFILE} && rm ${TAP_LOCKFILE} &
JUPYTER_PID=$!
LOCAL_PORT=5902
LOGIN_PORT=$(tap_get_port)
echo "TACC: got login node jupyter port ${LOGIN_PORT}"
JUPYTER_URL="https://frontera.tacc.utexas.edu:${LOGIN_PORT}/?token=${TAP_TOKEN}"
if ! $(ps -fu ${USER} | grep ${JUPYTER_BIN} | grep -qv grep) ; then
    # sometimes jupyter has a bad day. give it another chance to be awesome.
    echo "TACC: first jupyter launch failed. Retrying..."
    nohup ${JUPYTER_BIN} ${JUPYTER_ARGS} &> ${JUPYTER_LOGFILE} && rm ${TAP_LOCKFILE} &
fi
if ! $(ps -fu ${USER} | grep ${JUPYTER_BIN} | grep -qv grep) ; then
    # jupyter will not be working today. sadness.
    echo "TACC: ERROR - jupyter failed to launch"
    echo "TACC: ERROR - this is often due to an issue in your python or conda environment"
    echo "TACC: ERROR - jupyter logfile contents:"
    cat ${JUPYTER_LOGFILE}
    echo "TACC: job ${SLURM_JOB_ID} execution finished at: $(date)"
    exit 1
fi
NUM_LOGINS=4
for i in $(seq ${NUM_LOGINS}); do
    ssh -q -f -g -N -R ${LOGIN_PORT}:${NODE_HOSTNAME}:${LOCAL_PORT} login${i}
done
if [ $(ps -fu ${USER} | grep ssh | grep login | grep -vc grep) != ${NUM_LOGINS} ]; then
    # jupyter will not be working today. sadness.
    echo "TACC: ERROR - ssh tunnels failed to launch"
    echo "TACC: ERROR - this is often due to an issue with your ssh keys"
    echo "TACC: ERROR - undo any recent mods in ${HOME}/.ssh"
    echo "TACC: ERROR - or submit a TACC consulting ticket with this error"
    echo "TACC: job ${SLURM_JOB_ID} execution finished at: $(date)"
    exit 1
fi
echo "TACC: created reverse ports on Frontera logins"
echo "TACC: Your jupyter notebook server is now running at ${JUPYTER_URL}"
TAP_CONNECTION=${HOME}/.tap/.${SLURM_JOB_ID}.url
echo ${JUPYTER_URL} > ${TAP_CONNECTION}
echo $(date) > ${TAP_LOCKFILE}
while [ -f ${TAP_LOCKFILE} ]; do
    sleep 1
done
echo "TACC: release port returned $(tap_release_port ${LOGIN_PORT})"
sleep 1
echo "TACC: job ${SLURM_JOB_ID} execution finished at: $(date)"

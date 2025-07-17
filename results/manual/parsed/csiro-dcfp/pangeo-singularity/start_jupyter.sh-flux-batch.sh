#!/bin/bash
#FLUX: --job-name=jupyter
#FLUX: -n=2
#FLUX: -c=4
#FLUX: --queue=workq
#FLUX: -t=10800
#FLUX: --urgency=16

module load singularity
kill_server() {
    if [[ $JNPID != -1 ]]; then
        echo -en "\nKilling Jupyter Notebook Server with PID=$JNPID ... "
        kill $JNPID
        echo -e "Done\n"
        exit 0
    else
        exit 1
    fi
}
groupRepository=/group/$PAWSEY_PROJECT/singularity/groupRepository
userDirectory="${MYSCRATCH}/sandpit"
mkdir -p $userDirectory
cd $userDirectory
image="docker://matear/pangeo-mac:mod1"
imagename=${image##*/}
imagename=$groupRepository/${imagename/:/_}.sif
if [ -f $imagename ]; then
    echo -e "Using existing build of ${image} at ${imagename}\n"
else
    echo "Pulling and building ${image}..."
    singularity pull $imagename $image
    echo -e "Done\n"
fi
echo "Starting dask scheduler..."
singularity exec -C -B ${userDirectory}:/home/joyvan -B ${userDirectory}:$HOME ${imagename} \
dask-scheduler --scheduler-file $MYSCRATCH/scheduler.json --idle-timeout 0 &
sleep 20
echo -e "Done\n"
let DASK_PORT=8787
PORT=8888
pfound="0"
while [ $PORT -lt 65535 ] ; do
    check=$( netstat -tuna | awk '{print $4}' | grep ":$PORT *" )
    if [ "$check" == "" ] ; then
      pfound="1"
      break
    fi
    : $((++PORT))
done
if [ $pfound -eq 0 ] ; then
  echo "No available communication port found to establish the SSH tunnel."
  echo "Try again later. Exiting."
  exit
fi
let LOCALHOST_PORT=$PORT
HOST=$(hostname)
HOSTIP=$(hostname -i)
logDirectory="$MYSCRATCH/logs"
mkdir -p $logDirectory
LOGFILE=$logDirectory/pangeo_jupyter_log.$(date +%Y%m%dT%H%M%S)
echo -e "Starting jupyter notebook (logging jupyter notebook session on ${HOST} to ${LOGFILE})...\n"
singularity exec -C -B ${userDirectory}:/home/joyvan -B ${userDirectory}:$HOME ${imagename} \
jupyter lab --no-browser --ip=$HOST --notebook-dir=${userDirectory} \
>& $LOGFILE &
JNPID=$!
ELAPSED=0
ADDRESS=
while [[ $ADDRESS != *"${HOST}"* ]]; do
    sleep 1
    ELAPSED=$(($ELAPSED+1))
    ADDRESS=$(grep -e '^\[.*\]\s*http://.*:.*/\?token=.*' $LOGFILE | head -n 1 | awk -F'//' '{print $NF}')
    if [[ $ELAPSED -gt 360 ]]; then
        echo -e "Something went wrong:\n-----"
        cat $LOGFILE
        echo "-----"
        kill_server
    fi
done
PORT=$(echo $ADDRESS | awk -F':' ' { print $2 } ' | awk -F'/' ' { print $1 } ')
TOKEN=$(echo $ADDRESS | awk -F'=' ' { print $NF } ')
cat << EOF
  Run the following command on your local computer:
    ssh -N -l $USER -L ${LOCALHOST_PORT}:${HOST}:$PORT zeus.pawsey.org.au
  Log in with your Username/Password or SSH keys.
  Then open a browser and go to:
    Jupyter notebook : http://localhost:${LOCALHOST_PORT} 
    Dask dashboard : http://localhost:${LOCALHOST_PORT}/proxy/${DASK_PORT}/status
  The Jupyter web interface will ask you for a token. Use the following:
    $TOKEN
  Note that anyone to whom you give the token can access (and modify/delete)
  files in your PAWSEY spaces, regardless of the file permissions you
  have set. SHARE TOKENS RARELY AND WISELY!
  To stop the server, press Ctrl-C.
EOF
sleep inf

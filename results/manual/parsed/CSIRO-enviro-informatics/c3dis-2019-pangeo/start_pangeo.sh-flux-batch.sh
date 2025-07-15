#!/bin/bash
#FLUX: --job-name=nerdy-plant-5279
#FLUX: -c=10
#FLUX: -t=14400
#FLUX: --priority=16

export PATH='/home/lei053/miniconda3/bin:$PATH'

module unload numpy
module unload python
export PATH=/home/lei053/miniconda3/bin:$PATH
source activate pyAODN
kill_server() {
    if [[ $JNPID != -1 ]]; then
        echo -en "\nKilling Jupyter Notebook Server with PID=$JNPID ... "
        kill $JNPID
        echo "done"
        exit 0
    else
        exit 1
    fi
}
let DASK_PORT=8787
let LOCALHOST_PORT=8888
JNHOST=$(hostname)
JNIP=$(hostname -i)
LOGFILE=/home/lei053/pangeo_jupyter_log.$(date +%Y%m%dT%H%M%S)
echo "Logging jupyter notebook session on $JNHOST to $LOGFILE"
jupyter notebook $@ --no-browser --ip=$JNHOST >& $LOGFILE &
JNPID=$!
echo -en "\nStarting jupyter notebook server, please wait ... "
ELAPSED=0
ADDRESS=
while [[ $ADDRESS != *"${JNHOST}"* ]]; do
    sleep 1
    ELAPSED=$(($ELAPSED+1))
    ADDRESS=$(grep -e '^\[.*\]\s*http://.*:.*/\?token=.*' $LOGFILE | head -n 1 | awk -F'//' '{print $NF}')
    if [[ $ELAPSED -gt 60 ]]; then
        echo -e "something went wrong\n---"
        cat $LOGFILE
        echo "---"
        kill_server
    fi
done
echo -e "done\n---\n"
HOST=$(echo $ADDRESS | awk -F':' ' { print $1 } ')
PORT=$(echo $ADDRESS | awk -F':' ' { print $2 } ' | awk -F'/' ' { print $1 } ')
TOKEN=$(echo $ADDRESS | awk -F'=' ' { print $NF } ')
cat << EOF
Run the following command on your desktop or laptop:
    ssh -N -l $USER -L ${LOCALHOST_PORT}:${JNHOST}:$PORT zeus.pawsey.org.au
Log in with your Username/Password or SSH keys.
Then open a browser and go to http://localhost:${LOCALHOST_PORT}. The Jupyter web
interface will ask you for a token. Use the following:
    $TOKEN
Note that anyone to whom you give the token can access (and modify/delete)
files in your PAWSEY spaces, regardless of the file permissions you
have set. SHARE TOKENS RARELY AND WISELY!
To stop the server, press Ctrl-C.
EOF
sleep inf

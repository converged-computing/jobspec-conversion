#!/bin/bash
#FLUX: --job-name=jupyter_notebook
#FLUX: -c=8
#FLUX: --queue=workq
#FLUX: -t=28800
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='$MYSCRATCH/singularity'
export SINGULARITY_TMPDIR='$MYSCRATCH/singularity'
export SINGULARITY_BINDPATH='$MYSOFTWARE:$MYSOFTWARE,$MYSCRATCH:$MYSCRATCH,/run:/run,$HOME:$HOME '
export SINGULARITYENV_PREPEND_PATH='/srv/conda/envs/notebook/bin:/srv/conda/condabin:/srv/conda/bin'
export SINGULARITYENV_XDG_DATA_HOME='$MYSCRATCH/.local'
export SINGULARITYENV_OMP_NUM_THREADS='8  #To define the number of threads'
export SINGULARITYENV_OMP_PROC_BIND='close  #To bind (fix) threads (allocating them as close as possible)'
export SINGULARITYENV_OMP_PLACES='cores     #To bind threads to cores'

notebook_dir=$1 #"${MYSCRATCH}/"
export SINGULARITY_CACHEDIR=$MYSCRATCH/singularity
export SINGULARITY_TMPDIR=$MYSCRATCH/singularity
export SINGULARITY_BINDPATH=$MYSOFTWARE:$MYSOFTWARE,$MYSCRATCH:$MYSCRATCH,/run:/run,$HOME:$HOME 
export SINGULARITYENV_PREPEND_PATH=/srv/conda/envs/notebook/bin:/srv/conda/condabin:/srv/conda/bin
export SINGULARITYENV_XDG_DATA_HOME=$MYSCRATCH/.local
export SINGULARITYENV_OMP_NUM_THREADS=8  #To define the number of threads
export SINGULARITYENV_OMP_PROC_BIND=close  #To bind (fix) threads (allocating them as close as possible)
export SINGULARITYENV_OMP_PLACES=cores     #To bind threads to cores
image="docker://mrayson/jupyter_sfoda:latest"
mkdir -p ${notebook_dir}
cd ${notebook_dir}
imagename=${image##*/}
imagename=${imagename/:/_}.sif
host=$(hostname)
module load singularity
SINGULARITY_CACHEDIR=$MYSCRATCH/singularity singularity pull $imagename $image
echo $imagename $image
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
LOGFILE=$MYSCRATCH/pangeo_jupyter_log.$(date +%Y%m%dT%H%M%S)
echo "Logging jupyter notebook session to $LOGFILE"
srun --export=ALL singularity exec -C \
  -B ${notebook_dir}:/home/joyvan \
  -B ${notebook_dir}:${HOME} \
  -B/tmp:/tmp \
  -B $(mktemp -d):/run/user \
  ${imagename} \
  jupyter notebook $@ \
  --no-browser \
  --port=${LOCALHOST_PORT} --ip=$JNHOST \
  --notebook-dir=${dir} >& $LOGFILE &
  # Attempt at linking slurm...
  #-B /etc/slurm,/usr/lib64/liblua5.3.so.5,/usr/lib64/liblua.so.5.3,/usr/lib64/libmunge.so.2,/usr/lib64/slurm \
  #-B /usr/bin/sbatch,/usr/bin/scancel,/usr/bin/squeue,/var/run/munge,/run/munge  \
  #-B /usr/lib64/libreadline.so,/usr/lib64/libhistory.so,/usr/lib64/libtinfo.so,/usr/lib64/libjson-c.so.3 \
JNPID=$!
echo -en "\nStarting jupyter notebook server, please wait ... "
ELAPSED=0
ADDRESS=
while [[ $ADDRESS != *"${JNHOST}"* ]]; do
    sleep 1
    ELAPSED=$(($ELAPSED+1))
    #ADDRESS=$(grep -e '^\[.*\]\s*http://.*:.*/\?token=.*' $LOGFILE | head -n 1 | awk -F'//' '{print $NF}')
    ADDRESS=$(grep -e '\s*http://.*:.*/\?token=.*' $LOGFILE | head -n 1 | awk -F'//' '{print $NF}')
    #echo ADDRESS=$ADDRESS
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
    ssh -f -N -l $USER -L ${LOCALHOST_PORT}:${JNHOST}:$PORT -L $DASK_PORT:${JNHOST}:$DASK_PORT setonix.pawsey.org.au
Log in with your username/password or SSH keys (there will be no prompt).
Then open a browser and go to http://localhost:${LOCALHOST_PORT}. The Jupyter web
interface will ask you for a token. Use the following:
    $TOKEN
Note that anyone to whom you give the token can access (and modify/delete)
files in your PAWSEY spaces, regardless of the file permissions you
have set. SHARE TOKENS RARELY AND WISELY!
To stop the server, press Ctrl-C.
EOF
sleep inf

#!/bin/bash
#FLUX: --job-name=jupyter_notebook
#FLUX: -n=8
#FLUX: --queue=work
#FLUX: -t=28800
#FLUX: --priority=16

export PYTHONPATH='$MYSOFTWARE/code/sfoda'

dir=$1 #"${MYSCRATCH}/"
export PYTHONPATH=$MYSOFTWARE/code/sfoda
image="docker://mrayson/jupyter-sfoda:latest"
mkdir -p ${dir}
cd ${dir}
imagename=${image##*/}
imagename=${imagename/:/_}.sif
host=$(hostname)
port="8888"
DASK_PORT=8787
pfound="0"
while [ $port -lt 65535 ] ; do
  check=$( netstat -tuna | awk '{print $4}' | grep ":$port *" )
  if [ "$check" == "" ] ; then
    pfound="1"
    break
  fi
  : $((++port))
done
if [ $pfound -eq 0 ] ; then
  echo "No available communication port found to establish the SSH tunnel."
  echo "Try again later. Exiting."
  exit
fi
module load singularity/3.8.6
singularity pull $imagename $image
echo $imagename $image
echo "*****************************************************"
echo "Setup - from your laptop do:"
echo "ssh -N -f -L ${port}:${host}:${port} -L $DASK_PORT:${host}:$DASK_PORT $USER@$PAWSEY_CLUSTER.pawsey.org.au"
echo "*****"
echo "The launch directory is: $dir"
echo "*****************************************************"
echo ""
echo "*****************************************************"
echo "Terminate - from your laptop do:"
echo "kill \$( ps x | grep 'ssh.*-L *${port}:${host}:${port}' | awk '{print \$1}' )"
echo "*****************************************************"
echo ""
srun --export=ALL singularity exec -C \
  -B ${dir}:/home/joyvan \
  -B ${dir}:${HOME} \
  ${imagename} \
  jupyter notebook \
  --no-browser \
  --port=${port} --ip=0.0.0.0 \
  --notebook-dir=${dir}

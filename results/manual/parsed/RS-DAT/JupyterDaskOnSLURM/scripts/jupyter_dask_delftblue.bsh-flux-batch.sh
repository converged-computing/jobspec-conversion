#!/bin/bash
#FLUX: --job-name=fugly-truffle-9894
#FLUX: -c=4
#FLUX: --queue=compute
#FLUX: -t=82800
#FLUX: --urgency=16

source ~/.bashrc
conda activate jupyter_dask
node=`hostname -s`
port=`shuf -i 8400-9400 -n 1`
if [ -z ${lport:+x} ]; then lport="8889" ; else lport=${lport}; fi
echo "Run the following on your local machine: "
echo "ssh -i /path/to/private/ssh/key -N -L ${lport}:${node}:${port} ${USER}@login.delftblue.tudelft.nl"
jupyter lab --no-browser --port=${port} --ip=${node}

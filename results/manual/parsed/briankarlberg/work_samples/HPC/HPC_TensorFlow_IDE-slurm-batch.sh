#!/bin/bash
#FLUX: --job-name=jupyter-lab
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

[karlberb@exahead1 sample_count]$ cat j_lab_template.sh
JUPYTER_ENV=/home/groups/EllrottLab/sample_count/j_lab_py3_env
source $JUPYTER_ENV/bin/activate
node=$(hostname -s)
port=$(shuf -i8000-9999 -n1)
echo "Node: ${node}"
echo "Port: ${port}"
echo
echo "Example connection string:"
echo "  $ ssh ${USER}@exahead1.ohsu.edu -L ${port}:${node}:${port}"
echo
echo "Once the ssh connection is established, copy the URL printed below which"
echo "starts with http://127.0.0.1:${port}"
echo
echo "Navigate to that URL in your local browser."
srun jupyter-lab --no-browser --port=${port} --ip=${node}
echo 'jupyter lab now running'

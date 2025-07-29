#!/bin/bash
#FLUX: --job-name=hpc
#FLUX: --urgency=16

pwd; hostname; date
echo 'Hello World'
/usr/local/JARVICE/tools/bin/python_ssh_test 60
mpirun --hostfile /etc/JARVICE/nodes -pernode hostname
sleep 30
echo 'Exiting'

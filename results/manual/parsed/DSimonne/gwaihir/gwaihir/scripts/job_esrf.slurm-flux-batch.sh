#!/bin/bash
#FLUX: --job-name=dinosaur-snack-3155
#FLUX: -N=2
#FLUX: -n=4
#FLUX: -c=8
#FLUX: --queue=p9gpu
#FLUX: -t=3600
#FLUX: --urgency=16

reconstruct=$1          # if launched via the gui or terminal
username=$2             # username, if not specified, default to simonne
path=$3             # pynxraw directory with npz files and pynx_run.txt file
modes=$4                # if running modes analysis or not, in that case, run strain
echo "################################################################################################################"
echo "Reconstruct data via: " $reconstruct
echo "Username: " $username
echo "Working directory: " $path
echo "Running modes decomposition: " $modes
echo "################################################################################################################"
env | grep CUDA
scontrol --details show jobs \$SLURM_JOBID |grep RES
echo
nvidia-smi
echo
cd $path
echo "Moved to " $path
echo
echo "################################################################################################################"
echo "Running phase retrieval with PyNX ..."
echo "################################################################################################################"
echo
if [[ $reconstruct = "gui" ]]; then
    echo "################################################################################################################"
    echo "Loading pynx_run.txt arguments..."
    echo "/data/id01/inhouse/david/p9.dev/bin/pynx-id01cdi.py pynx_run.txt |& tee README_pynx.md"
    mpiexec -n $SLURM_NTASKS /data/id01/inhouse/david/p9.dev/bin/pynx-cdi-id01 pynx_run.txt |& tee README_pynx.md
    # Moving the results in gui_run/ sub-directory
    echo "Creating a subdirector gui_run/ and moving all the .cxi files there..."
    rm latest.cxi
    mv S*LLK*.cxi gui_run/
    mv README_pynx.md gui_run/
    cd gui_run/
    echo "################################################################################################################"
    echo
elif [[ $reconstruct = "terminal" ]]; then
    echo "################################################################################################################"
    echo "Loading pynx_run.txt arguments..."
    echo "/data/id01/inhouse/david/p9.dev/bin/pynx-id01cdi.py pynx_run.txt |& tee README_pynx_terminal.md"
    mpiexec -n $SLURM_NTASKS /data/id01/inhouse/david/p9.dev/bin/pynx-cdi-id01 pynx_run.txt |& tee README_pynx_terminal.md
    # Moving the results in terminal_run/ sub-directory
    echo "Creating a subdirector terminal_run/ and moving all the .cxi files there..."
    rm latest.cxi
    mkdir terminal_run/
    mv S*LLK*.cxi terminal_run/
    mv README_pynx_terminal.md terminal_run/
    cd terminal_run/
    echo "################################################################################################################"
    echo
fi
if [[ $modes = "true" ]]; then
    echo "################################################################################################################"
    echo "Running modes decomposition ..."
    echo "/data/id01/inhouse/david/p9.dev/bin/pynx-cdi-analysis.py *LLK* modes=1 modes_output=modes.h5 |& tee README_modes.md"
    /data/id01/inhouse/david/p9.dev/bin/pynx-cdi-analysis *LLK* modes=1 modes_output=modes.h5 |& tee README_modes.md
    echo "################################################################################################################"
    echo
fi

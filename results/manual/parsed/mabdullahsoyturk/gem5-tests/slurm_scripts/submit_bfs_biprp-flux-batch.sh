#!/bin/bash
#FLUX: --job-name=gem5-bfs-biprp
#FLUX: -n=4
#FLUX: -t=345600
#FLUX: --urgency=16

echo "Running gem5 command..."
date
echo "Runs BFS application with dblp graph and Bimodal Interval Prediction replacement policy."
python3 launch.py --graph-name=dblp.el --app-name=bfs --l2_replacement=BIPRP
date
RET=$?
echo
echo "Solver exited with return code: $RET"
exit $RET

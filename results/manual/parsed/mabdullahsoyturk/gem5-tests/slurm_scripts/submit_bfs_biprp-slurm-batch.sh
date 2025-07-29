#!/bin/bash
#SBATCH --job-name=gem5-bfs-biprp
#SBATCH --output=%j-gem5bfs.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000
#SBATCH --time=4-00:00:00

echo "Running gem5 command..."
date
echo "Runs BFS application with dblp graph and Bimodal Interval Prediction replacement policy."
python3 launch.py --graph-name=dblp.el --app-name=bfs --l2_replacement=BIPRP
date
RET=$?
echo
echo "Solver exited with return code: $RET"
exit $RET

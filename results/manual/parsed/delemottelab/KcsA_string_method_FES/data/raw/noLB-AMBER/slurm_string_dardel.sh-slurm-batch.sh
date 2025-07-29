#!/bin/bash
#SBATCH --job-name=noLB-AMBER
#SBATCH --account=snic2021-3-15
#SBATCH --output=slurm_out/string-%J_%a.out
#SBATCH --error=slurm_out/string-%J_%a.err
#SBATCH --mail-user=sergiopc@kth.se
#SBATCH --mail-type=ALL
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=128

ml PDC
ml GROMACS/2020.5-cpeCray-21.11
ml Anaconda3/2021.05
path_string_method_gmxapi=../../../../string-method-gmxapi/
iteration=$(ls -vd strings/string[0-9]*.txt|tail -n 1| sed  "s:strings/string\([0-9]*\).txt:\1:")
iterations_per_job=1
max_iteration=$((($iteration+$iterations_per_job)))
sed -i "s/\"max_iterations\": [0-9]*/\"max_iterations\": $max_iteration/" config.json
cmd="`which python`  ${path_string_method_gmxapi}/stringmethod/main.py --config_file=config.json"
echo "Command Run:"
echo $cmd
echo "Started at:"
date
$cmd
echo "Finished at:"
date

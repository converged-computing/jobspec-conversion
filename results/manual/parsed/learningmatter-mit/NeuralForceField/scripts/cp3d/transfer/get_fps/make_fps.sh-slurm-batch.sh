#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:1
#SBATCH --mem=300G
#SBATCH --time=2-23:40:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --no-requeue

export NFFDIR='/home/saxelrod/repo/nff/master/NeuralForceField'
export PYTHONPATH='$NFFDIR:$PYTHONPATH'

source $HOME/.bashrc
source activate nff
CONFIG="config/cov2_cl_test.json"
export NFFDIR=/home/saxelrod/repo/nff/master/NeuralForceField
export PYTHONPATH="$NFFDIR:$PYTHONPATH"
metrics_lst=$(cat $CONFIG | jq ".metrics")
metric_str="${metrics_lst/[/}"
metric_str="${metric_str/]/}"
metric_str="${metric_str//,/ }"
metrics=($metric_str)
echo $metric
for metric in ${metrics[@]}; do
	cmd="python make_fps.py --metric $metric --config_file $CONFIG "
	statement="Evaluating model using the $metric metric"
	echo $statement
	echo $cmd
	eval $cmd
	echo ""
done

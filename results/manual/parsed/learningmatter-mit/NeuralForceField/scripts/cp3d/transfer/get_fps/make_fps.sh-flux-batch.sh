#!/bin/bash
#FLUX: --job-name=delicious-omelette-7107
#FLUX: -c=32
#FLUX: --queue=sched_mit_rafagb_amd,sched_mit_rafagb
#FLUX: -t=258000
#FLUX: --urgency=16

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

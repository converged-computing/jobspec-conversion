#!/bin/bash
#FLUX: --job-name=misunderstood-kitty-7483
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --urgency=16

export src_dir='$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )'
export PYTHONPATH='${src_dir%/*/*}/src'
export QT_QPA_PLATFORM='offscreen'
export set='$set'
export config='$config'

echo "Activating virtual environment"
source activate /struct/mahamid/Irene/segmentation_ribo/.snakemake/conda/50db6a03
echo "done"
export src_dir="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export PYTHONPATH=${src_dir%/*/*}/src
echo PYTHONPATH=$PYTHONPATH
export QT_QPA_PLATFORM='offscreen'
usage()
{
    echo "usage: [[ [-set][-set set ]
                  [-config] [-config config] | [-h]]"
}
while [ "$1" != "" ]; do
    case $1 in
        -set | --set )   shift
                                set=$1
                                ;;
        -config | --config )   shift
                                config=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done
export set=$set
export config=$config
echo "Submitting job for set" $set
echo "Generating training partitions"
python3 $src_dir/generate_training_data.py -config $config -set $set
echo "Starting training script for set" $set
python3 $src_dir/training.py -config $config -set $set -gpu $CUDA_VISIBLE_DEVICES

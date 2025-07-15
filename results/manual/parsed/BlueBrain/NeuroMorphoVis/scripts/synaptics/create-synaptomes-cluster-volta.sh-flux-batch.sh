#!/bin/bash
#FLUX: --job-name="synaptome"
#FLUX: --queue=prod
#FLUX: -t=57600
#FLUX: --priority=16

BLENDER=$PWD/../../../../../../blender
CIRCUIT_CONFIG='/gpfs/bbp.cscs.ch/project/proj83/circuits/Bio_M/20200731/CircuitConfig'
CIRCUIT_CONFIG='/gpfs/bbp.cscs.ch/project/proj83/circuits/Bio_M/20200805/CircuitConfig.pre-fixL3'
GIDS_FILE='/gpfs/bbp.cscs.ch/project/proj83/visualization-SSCXDIS-178/synaptomes-data/iteration_2/cvs-files/gids/S1DZ.gids'
OUTPUT_DIRECTORY='/gpfs/bbp.cscs.ch/project/proj83/visualization-SSCXDIS-178/synaptome'
OUTPUT_DIRECTORY='/hdd1/projects-data/11.25.2020-synaptomes-with-spines'
OUTPUT_DIRECTORY='/hdd1/projects-data/2021.01.13-synaptomes-final/mtypes'
OUTPUT_DIRECTORY='/hdd1/projects-data/2021.01.13-synaptomes-final/excitatory_inhibitory'
OUTPUT_DIRECTORY='/gpfs/bbp.cscs.ch/project/proj83/visualization-SSCXDIS-178/synaptome/trial-2-26.02.2021'
OUTPUT_DIRECTORY='/gpfs/bbp.cscs.ch/project/proj83/visualization-SSCXDIS-178/synaptome/trial-4-08.03.2020'
SHOW_EXC_INH='no'
COLOR_MAP_FILE=$PWD'/data/ColorMap'
NEURON_COLOR='255_255_255'
SYNAPSE_PERCENTAGE='100'
SYNAPSE_SIZE='2.0'
CLOSE_UP_SIZE='50'
FULL_VIEW_RESOLUTION='2000'
CLOSE_UP_RESOLUTION='1000'
BACKGROUND_IMAGE='/gpfs/bbp.cscs.ch/project/proj83/visualization-SSCXDIS-178/synaptomes-data/backgrounds/background_1900x1080.png'
EXECUTION='serial'
NUMBER_PARALLEL_CORES='10'
BOOL_ARGS=''
if [ "$SHOW_EXC_INH" == "yes" ];
    then BOOL_ARGS+=' --show-exc-inh '; fi
nvidia-smi
module load unstable
module load virtualgl/2.5.2
echo 'CREATING SYNAPTOMES ...';
DISPLAY=:5 $PWD/../../../../../python/bin/python3.7m create-synaptomes.py                 \
    --blender-executable=$BLENDER                                                                   \
    --circuit-config=$CIRCUIT_CONFIG                                                                \
    --gids-file=$GIDS_FILE                                                                          \
    --execution=$EXECUTION                                                                          \
    --number-parallel-cores=$NUMBER_PARALLEL_CORES                                                  \
    --output-directory=$OUTPUT_DIRECTORY                                                            \
    --color-map=$COLOR_MAP_FILE                                                                     \
    --neuron-color=$NEURON_COLOR                                                                    \
    --full-view-resolution=$FULL_VIEW_RESOLUTION                                                    \
    --close-up-resolution=$CLOSE_UP_RESOLUTION                                                      \
    --synapse-percentage=$SYNAPSE_PERCENTAGE                                                        \
    --synapse-size=$SYNAPSE_SIZE                                                                    \
    --close-up-size=$CLOSE_UP_SIZE                                                                  \
    --background-image=$BACKGROUND_IMAGE                                                            \
    $BOOL_ARGS;

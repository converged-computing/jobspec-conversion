#!/bin/bash
#FLUX: --job-name=lovely-parsnip-3127
#FLUX: -N=2
#FLUX: --queue=develgpus
#FLUX: -t=600
#FLUX: --urgency=16

export CO_SIM_ROOT_PATH='${PROJECT_cslns}/${LOGNAME}/multiscale-cosim'
export CO_SIM_MODULES_ROOT_PATH='${CO_SIM_ROOT_PATH}/TVB-NEST-usecase1'
export CO_SIM_USE_CASE_ROOT_PATH='${CO_SIM_ROOT_PATH}/TVB-NEST-usecase1'
export CO_SIM_NEST='${CO_SIM_ROOT_PATH}/nest-simulator'
export PATH='${CO_SIM_NEST}/bin:${PATH}'
export PYTHONPATH='${PYTHONPATH}:${CO_SIM_USE_CASE_ROOT_PATH}'

module load Stages/2022 GCCcore/.11.2.0 GCC/11.2.0 ParaStationMPI/5.5.0-1 Python/3.9.6 mpi4py/3.1.3 CMake/3.21.1 ZeroMQ/4.3.4 Flask/2.0.2
export CO_SIM_ROOT_PATH="${PROJECT_cslns}/${LOGNAME}/multiscale-cosim"
export CO_SIM_MODULES_ROOT_PATH="${CO_SIM_ROOT_PATH}/TVB-NEST-usecase1"
export CO_SIM_USE_CASE_ROOT_PATH="${CO_SIM_ROOT_PATH}/TVB-NEST-usecase1"
export CO_SIM_NEST=${CO_SIM_ROOT_PATH}/nest-simulator
export PATH=${CO_SIM_NEST}/bin:${PATH}
export PYTHONPATH=${PYTHONPATH}:${CO_SIM_NEST}/lib64/python3.9/site-packages
export PYTHONPATH=${PYTHONPATH}:${CO_SIM_ROOT_PATH}/site-packages
export PYTHONPATH=${PYTHONPATH}:${CO_SIM_USE_CASE_ROOT_PATH}
srun -n 1 --exact python3 ${CO_SIM_USE_CASE_ROOT_PATH}/main.py --global-settings ${CO_SIM_USE_CASE_ROOT_PATH}/EBRAINS_WorkflowConfigurations/general/global_settings.xml --action-plan ${CO_SIM_USE_CASE_ROOT_PATH}/userland/configs/hpc/plans/cosim_alpha_brunel_hpc.xml

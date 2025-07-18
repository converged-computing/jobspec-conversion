#!/bin/bash
#FLUX: --job-name=muffled-eagle-4054
#FLUX: --urgency=16

export GPTUNEROOT='$PWD'
export PYTHONPATH='$PYTHONPATH:$GPTUNEROOT/GPTune/'
export PYTHONWARNINGS='ignore'

cd ../../
ModuleEnv='cori-haswell-openmpi-gnu'
if [ $ModuleEnv = 'cori-haswell-openmpi-gnu' ]; then
    PY_VERSION=3.8
    PY_TIME=2020.11
    MKL_TIME=2020.2.254
    module load gcc/8.3.0
    module unload cray-mpich
    module unload openmpi
    module unload PrgEnv-intel
    module load PrgEnv-gnu
    module load openmpi/4.1.2
    module unload craype-hugepages2M
    module unload cray-libsci
    module unload atp
    module load python/$PY_VERSION-anaconda-$PY_TIME
    export MKLROOT=/opt/intel/compilers_and_libraries_$MKL_TIME/linux/mkl
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/compilers_and_libraries_$MKL_TIME/linux/mkl/lib/intel64
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD/examples/SuperLU_DIST/superlu_dist/parmetis-github/lib/
    export PYTHONPATH=~/.local/cori/$PY_VERSION-anaconda-$PY_TIME/lib/python$PY_VERSION/site-packages
    export PYTHONPATH=~/.local/cori/$PY_VERSION-anaconda-$PY_TIME/lib/python$PY_VERSION/site-packages/gptune/:$PYTHONPATH
    proc=haswell
    cores=32
    machine=cori
    software_json=$(echo ",\"software_configuration\":{\"openmpi\":{\"version_split\": [4,1,2]},\"hypre\":{\"version_split\": [2,19,0]},\"gcc\":{\"version_split\": [8,3,0]}}")
else
    echo "Untested ModuleEnv: $ModuleEnv, please add the corresponding definitions in this file"
    exit
fi    
export GPTUNEROOT=$PWD
export PYTHONPATH=$PYTHONPATH:$GPTUNEROOT/autotune/
export PYTHONPATH=$PYTHONPATH:$GPTUNEROOT/scikit-optimize/
export PYTHONPATH=$PYTHONPATH:$GPTUNEROOT/mpi4py/
export PYTHONPATH=$PYTHONPATH:$GPTUNEROOT/GPTune/
export PYTHONWARNINGS=ignore
cd -
nodes=1  # number of nodes to be used
machine_json=$(echo ",\"machine_configuration\":{\"machine_name\":\"$machine\",\"$proc\":{\"nodes\":$nodes,\"cores\":$cores}}")
tp=Hypre 
app_json=$(echo "{\"tuning_problem_name\":\"$tp\"")
echo "$app_json$machine_json$software_json}" | jq '.' > .gptune/meta.json                  
nxmax=100
nymax=100
nzmax=100
ntask=1
nrun=1000
npilot=500
nprocmin_pernode=1  # nprocmin_pernode=cores means flat MPI
tuner='GPTune'
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${nrun} -npilot ${npilot} -optimization ${tuner}   2>&1 | tee a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_ntask${ntask}_nrun${nrun}_npilot${npilot}_${tuner}

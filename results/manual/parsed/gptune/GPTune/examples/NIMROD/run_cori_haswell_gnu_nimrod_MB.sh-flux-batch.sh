#!/bin/bash
#FLUX: --job-name=GPTune_nimrod
#FLUX: -N=9
#FLUX: --queue=premium
#FLUX: -t=36000
#FLUX: --urgency=16

export GPTUNEROOT='$PWD'
export PYTHONPATH='$PYTHONPATH:$GPTUNEROOT/GPTune/'
export PYTHONWARNINGS='ignore'

cd ../../
ModuleEnv='cori-haswell-openmpi-gnu'
if [ $ModuleEnv = 'cori-haswell-openmpi-gnu' ]; then
    module load python/3.7-anaconda-2019.10
    module unload cray-mpich
    module swap PrgEnv-intel PrgEnv-gnu
    module load openmpi/4.0.1
    export MKLROOT=/opt/intel/compilers_and_libraries_2019.3.199/linux/mkl
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/compilers_and_libraries_2019.3.199/linux/mkl/lib/intel64
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD/examples/SuperLU_DIST/superlu_dist/parmetis-4.0.3/install/lib/
    export PYTHONPATH=~/.local/cori/3.7-anaconda-2019.10/lib/python3.7/site-packages
    proc=haswell
    cores=32
    machine=cori
    software_json=$(echo ",\"software_configuration\":{\"openmpi\":{\"version_split\": [4,0,1]},\"scalapack\":{\"version_split\": [2,1,0]},\"gcc\":{\"version_split\": [8,3,0]}}")
    loadable_software_json=$(echo ",\"loadable_software_configurations\":{\"openmpi\":{\"version_split\": [4,0,1]},\"scalapack\":{\"version_split\": [2,1,0]},\"gcc\":{\"version_split\": [8,3,0]}}")
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
nodes=16  # number of nodes to be used
machine_json=$(echo ",\"machine_configuration\":{\"machine_name\":\"$machine\",\"$proc\":{\"nodes\":$nodes,\"cores\":$cores}}")
loadable_machine_json=$(echo ",\"loadable_machine_configurations\":{\"$machine\":{\"$proc\":{\"nodes\":$nodes,\"cores\":$cores}}}")
tp=NIMROD
app_json=$(echo "{\"tuning_problem_name\":\"$tp\"")
echo "$app_json$machine_json$software_json$loadable_machine_json$loadable_software_json}" | jq '.' > .gptune/meta.json
rm -rf gptune.db/NIMROD.json
for tuner in GPTuneBand
do
ntask=1
nstepmax=30
nstepmin=3
Nloop=1
bmin=1
bmax=8
eta=2
mpirun --mca btl self,tcp,vader --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1  python ./nimrod_single_MB.py -bmin ${bmin} -bmax ${bmax} -eta ${eta} -ntask ${ntask} -Nloop ${Nloop} -optimization ${tuner} -nstepmax ${nstepmax} -nstepmin ${nstepmin} | tee a.out_nimrod_single_MB_nstepmax${nstepmax}_nstepmin${nstepmin}_Nloop${Nloop}_tuner${tuner}_bmin${bmin}_bmax${bmax}_eta${eta}
done

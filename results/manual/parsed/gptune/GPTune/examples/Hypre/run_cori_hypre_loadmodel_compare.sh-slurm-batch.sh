#!/bin/bash
#FLUX: --job-name=test_driver
#FLUX: -N=2
#FLUX: -c=8
#FLUX: --queue=premium
#FLUX: -t=72000
#FLUX: --urgency=16

export MKLROOT='/opt/intel/compilers_and_libraries_2019.3.199/linux/mkl'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/opt/intel/compilers_and_libraries_2019.3.199/linux/mkl/lib/intel64:/opt/intel/compilers_and_libraries_2019.3.199/linux/compiler/lib/intel64'
export PYTHONPATH='$PYTHONPATH:$PWD/examples/hypre-driver/'
export PYTHONWARNINGS='ignore'

module load python/3.7-anaconda-2019.10
module unload cray-mpich
module swap PrgEnv-intel PrgEnv-gnu
export MKLROOT=/opt/intel/compilers_and_libraries_2019.3.199/linux/mkl
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/compilers_and_libraries_2019.3.199/linux/mkl/lib/intel64:/opt/intel/compilers_and_libraries_2019.3.199/linux/compiler/lib/intel64
module load openmpi/4.0.1
export PYTHONPATH=~/.local/cori/3.7-anaconda-2019.10/lib/python3.7/site-packages
export PYTHONPATH=$PYTHONPATH:$PWD/autotune/
export PYTHONPATH=$PYTHONPATH:$PWD/scikit-optimize/
export PYTHONPATH=$PYTHONPATH:$PWD/mpi4py/
export PYTHONPATH=$PYTHONPATH:$PWD/GPTune/
export PYTHONPATH=$PYTHONPATH:$PWD/examples/hypre-driver/spt/
export PYTHONPATH=$PYTHONPATH:$PWD/examples/hypre-driver/
export PYTHONWARNINGS=ignore
CCC=mpicc
CCCPP=mpicxx
FTN=mpif90
nxmax=200
nymax=200
nzmax=200
ntask=5
nodes=1
cores=32
nprocmin_pernode=32  # nprocmin_pernode=cores means flat MPI 
cd examples
firstrun=100
mkdir hypre_loadmodel_eval
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre_historydb.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nodes ${nodes} -cores ${cores} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${firstrun} -machine cori -jobid 0 2>&1 | tee hypre_loadmodel_eval/a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_nodes${nodes}_core${cores}_ntask${ntask}_nrun${firstrun}
cp hypre.json hypre_loadmodel_eval/hypre.first_nrun${firstrun}.json
cp modeling_stat_hypre.csv hypre_loadmodel_eval/modeling_stat_hypre.first_nrun${firstrun}.csv
rm hypre.json
rm modeling_stat_hypre.csv
nrun=1
cp hypre_loadmodel_eval/hypre.first_nrun${firstrun}.json hypre.json
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre_historydb.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nodes ${nodes} -cores ${cores} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${nrun} -machine cori -jobid 0 2>&1 | tee hypre_loadmodel_eval/a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_nodes${nodes}_core${cores}_ntask${ntask}_nrun${nrun}_history_db
cp hypre.json hypre_loadmodel_eval/hypre.history_db_nrun${nrun}.json
cp modeling_stat_hypre.csv hypre_loadmodel_eval/modeling_stat_hypre.history_db_nrun${nrun}.csv
rm hypre.json
rm modeling_stat_hypre.csv
nrun=1
cp hypre_loadmodel_eval/hypre.first_nrun${firstrun}.json hypre.json
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre_loadmodel.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nodes ${nodes} -cores ${cores} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${nrun} -machine cori -jobid 0 2>&1 | tee hypre_loadmodel_eval/a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_nodes${nodes}_core${cores}_ntask${ntask}_nrun${nrun}_loadmodel
cp hypre.json hypre_loadmodel_eval/hypre.loadmodel_nrun${nrun}.json
cp modeling_stat_hypre.csv hypre_loadmodel_eval/modeling_stat_hypre.loadmodel_nrun${nrun}.csv
rm hypre.json
rm modeling_stat_hypre.csv
firstrun=50
mkdir hypre_loadmodel_eval2
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre_historydb.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nodes ${nodes} -cores ${cores} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${firstrun} -machine cori -jobid 0 2>&1 | tee hypre_loadmodel_eval2/a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_nodes${nodes}_core${cores}_ntask${ntask}_nrun${firstrun}
cp hypre.json hypre_loadmodel_eval2/hypre.first_nrun${firstrun}.json
cp modeling_stat_hypre.csv hypre_loadmodel_eval2/modeling_stat_hypre.first_nrun${firstrun}.csv
rm hypre.json
rm modeling_stat_hypre.csv
nrun=1
cp hypre_loadmodel_eval2/hypre.first_nrun${firstrun}.json hypre.json
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre_historydb.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nodes ${nodes} -cores ${cores} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${nrun} -machine cori -jobid 0 2>&1 | tee hypre_loadmodel_eval2/a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_nodes${nodes}_core${cores}_ntask${ntask}_nrun${nrun}_history_db
cp hypre.json hypre_loadmodel_eval2/hypre.history_db_nrun${nrun}.json
cp modeling_stat_hypre.csv hypre_loadmodel_eval2/modeling_stat_hypre.history_db_nrun${nrun}.csv
rm hypre.json
rm modeling_stat_hypre.csv
nrun=1
cp hypre_loadmodel_eval2/hypre.first_nrun${firstrun}.json hypre.json
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre_loadmodel.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nodes ${nodes} -cores ${cores} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${nrun} -machine cori -jobid 0 2>&1 | tee hypre_loadmodel_eval2/a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_nodes${nodes}_core${cores}_ntask${ntask}_nrun${nrun}_loadmodel
cp hypre.json hypre_loadmodel_eval2/hypre.loadmodel_nrun${nrun}.json
cp modeling_stat_hypre.csv hypre_loadmodel_eval2/modeling_stat_hypre.loadmodel_nrun${nrun}.csv
rm hypre.json
rm modeling_stat_hypre.csv
firstrun=50
nrun=25
cp hypre_loadmodel_eval2/hypre.first_nrun${firstrun}.json hypre.json
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre_historydb.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nodes ${nodes} -cores ${cores} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${nrun} -machine cori -jobid 0 2>&1 | tee hypre_loadmodel_eval2/a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_nodes${nodes}_core${cores}_ntask${ntask}_nrun${nrun}_history_db
cp hypre.json hypre_loadmodel_eval2/hypre.history_db_nrun${nrun}.json
cp modeling_stat_hypre.csv hypre_loadmodel_eval2/modeling_stat_hypre.history_db_nrun${nrun}.csv
rm hypre.json
rm modeling_stat_hypre.csv
firstrun=50
nrun=25
cp hypre_loadmodel_eval2/hypre.first_nrun${firstrun}.json hypre.json
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre_loadmodel.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nodes ${nodes} -cores ${cores} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${nrun} -update -1 -machine cori -jobid 0 2>&1 | tee hypre_loadmodel_eval2/a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_nodes${nodes}_core${cores}_ntask${ntask}_nrun${nrun}_loadmodel_update
cp hypre.json hypre_loadmodel_eval2/hypre.loadmodel_nrun${nrun}_update.json
cp modeling_stat_hypre.csv hypre_loadmodel_eval2/modeling_stat_hypre.loadmodel_nrun${nrun}_update.csv
rm hypre.json
rm modeling_stat_hypre.csv
firstrun=50
nrun=25
cp hypre_loadmodel_eval2/hypre.first_nrun${firstrun}.json hypre.json
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre_loadmodel.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nodes ${nodes} -cores ${cores} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${nrun} -update 5 -machine cori -jobid 0 2>&1 | tee hypre_loadmodel_eval2/a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_nodes${nodes}_core${cores}_ntask${ntask}_nrun${nrun}_loadmodel_update5
cp hypre.json hypre_loadmodel_eval2/hypre.loadmodel_nrun${nrun}_update5.json
cp modeling_stat_hypre.csv hypre_loadmodel_eval2/modeling_stat_hypre.loadmodel_nrun${nrun}_update5.csv
rm hypre.json
rm modeling_stat_hypre.csv
firstrun=20
mkdir hypre_loadmodel_eval3
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre_historydb.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nodes ${nodes} -cores ${cores} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${firstrun} -machine cori -jobid 0 2>&1 | tee hypre_loadmodel_eval3/a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_nodes${nodes}_core${cores}_ntask${ntask}_nrun${firstrun}
cp hypre.json hypre_loadmodel_eval3/hypre.first_nrun${firstrun}.json
cp modeling_stat_hypre.csv hypre_loadmodel_eval3/modeling_stat_hypre.first_nrun${firstrun}.csv
rm hypre.json
rm modeling_stat_hypre.csv
nrun=1
cp hypre_loadmodel_eval3/hypre.first_nrun${firstrun}.json hypre.json
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre_historydb.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nodes ${nodes} -cores ${cores} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${nrun} -machine cori -jobid 0 2>&1 | tee hypre_loadmodel_eval3/a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_nodes${nodes}_core${cores}_ntask${ntask}_nrun${nrun}_history_db
cp hypre.json hypre_loadmodel_eval3/hypre.history_db_nrun${nrun}.json
cp modeling_stat_hypre.csv hypre_loadmodel_eval3/modeling_stat_hypre.history_db_nrun${nrun}.csv
rm hypre.json
rm modeling_stat_hypre.csv
nrun=1
cp hypre_loadmodel_eval3/hypre.first_nrun${firstrun}.json hypre.json
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre_loadmodel.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nodes ${nodes} -cores ${cores} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${nrun} -machine cori -jobid 0 2>&1 | tee hypre_loadmodel_eval3/a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_nodes${nodes}_core${cores}_ntask${ntask}_nrun${nrun}_loadmodel
cp hypre.json hypre_loadmodel_eval3/hypre.loadmodel_nrun${nrun}.json
cp modeling_stat_hypre.csv hypre_loadmodel_eval3/modeling_stat_hypre.loadmodel_nrun${nrun}.csv
rm hypre.json
rm modeling_stat_hypre.csv
firstrun=20
nrun=10
cp hypre_loadmodel_eval3/hypre.first_nrun${firstrun}.json hypre.json
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre_historydb.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nodes ${nodes} -cores ${cores} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${nrun} -machine cori -jobid 0 2>&1 | tee hypre_loadmodel_eval3/a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_nodes${nodes}_core${cores}_ntask${ntask}_nrun${nrun}_history_db
cp hypre.json hypre_loadmodel_eval3/hypre.history_db_nrun${nrun}.json
cp modeling_stat_hypre.csv hypre_loadmodel_eval3/modeling_stat_hypre.history_db_nrun${nrun}.csv
rm hypre.json
rm modeling_stat_hypre.csv
firstrun=20
nrun=10
cp hypre_loadmodel_eval3/hypre.first_nrun${firstrun}.json hypre.json
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre_loadmodel.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nodes ${nodes} -cores ${cores} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${nrun} -update -1 -machine cori -jobid 0 2>&1 | tee hypre_loadmodel_eval3/a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_nodes${nodes}_core${cores}_ntask${ntask}_nrun${nrun}_loadmodel_update
cp hypre.json hypre_loadmodel_eval3/hypre.loadmodel_nrun${nrun}_update.json
cp modeling_stat_hypre.csv hypre_loadmodel_eval3/modeling_stat_hypre.loadmodel_nrun${nrun}_update.csv
rm hypre.json
rm modeling_stat_hypre.csv
firstrun=20
nrun=10
cp hypre_loadmodel_eval3/hypre.first_nrun${firstrun}.json hypre.json
mpirun --oversubscribe --mca pmix_server_max_wait 3600 --mca pmix_base_exchange_timeout 3600 --mca orte_abort_timeout 3600 --mca plm_rsh_no_tree_spawn true -n 1 python ./hypre_loadmodel.py -nxmax ${nxmax} -nymax ${nymax} -nzmax ${nzmax} -nodes ${nodes} -cores ${cores} -nprocmin_pernode ${nprocmin_pernode} -ntask ${ntask} -nrun ${nrun} -update 5 -machine cori -jobid 0 2>&1 | tee hypre_loadmodel_eval3/a.out_hypre_ML_nxmax${nxmax}_nymax${nymax}_nzmax${nzmax}_nodes${nodes}_core${cores}_ntask${ntask}_nrun${nrun}_loadmodel_update5
cp hypre.json hypre_loadmodel_eval3/hypre.loadmodel_nrun${nrun}_update5.json
cp modeling_stat_hypre.csv hypre_loadmodel_eval3/modeling_stat_hypre.loadmodel_nrun${nrun}_update5.csv
rm hypre.json
rm modeling_stat_hypre.csv

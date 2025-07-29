#!/bin/bash
#SBATCH --job-name=kripke
#SBATCH --account=p_readex
#SBATCH --mail-user=ondrej.vysocky@vsb.cz
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2200M
#SBATCH --time=00:02:00
#SBATCH --exclusive

export SCOREP_PROFILING_FORMAT='cube_tuple'
export SCOREP_METRIC_PAPI='PAPI_TOT_INS,PAPI_L3_TCM'

cd ../build
. ../readex_env/set_env_rdd.source
. ../environment.sh
export SCOREP_PROFILING_FORMAT=cube_tuple
export SCOREP_METRIC_PAPI=PAPI_TOT_INS,PAPI_L3_TCM
echo "running kripke for readex-dyn-detect"
srun -n 28 ./kripke $KRIPKE_COMMAND
echo "running kripke done"
echo "running readex-dyn-detect"
echo "phase region = $2"
readex-dyn-detect -p "Loop" -t 0.01 scorep-*/profile.cubex
echo
echo "running readex-dyn-detect done" 

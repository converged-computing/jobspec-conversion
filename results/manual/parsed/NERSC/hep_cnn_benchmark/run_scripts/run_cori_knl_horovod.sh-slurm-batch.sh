#!/bin/bash
#SBATCH --job-name=hep_train_tf
#SBATCH --account=dasrepo
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --constraint=knl

module load python/3.6-anaconda-4.4
source activate thorstendl-cori-2.7
configfile=cori_knl_224_adam.json
basedir=/global/cscratch1/sd/tkurth/atlas_dl/benchmark_runs
rundir=${basedir}/run_nnodes2_j14412531
mkdir -p ${rundir}
cp ../scripts/hep_classifier_tf_train_horovod.py ${rundir}/
cp -r ../scripts/networks ${rundir}/
cp ../configs/${configfile} ${rundir}/
cd ${rundir}
set -x
srun -N ${SLURM_NNODES} -n ${SLURM_NNODES} -c 272 -u \
    python hep_classifier_tf_train_horovod.py \
    --config=${configfile} \
    --num_tasks=${SLURM_NNODES} |& tee out.fp32.lag0.${SLURM_JOBID}

#!/bin/bash
#FLUX: --job-name=gassy-puppy-2679
#FLUX: -t=86400
#FLUX: --urgency=16

export SRDIR='out/sampler_semi_synth'
export Np='50'
export OPID='12,25,28'
export BASEDIR='out/semi_synth'
export SDIR='${BASEDIR}/samples.000'
export MDIR='${BASEDIR}/models.000'
export pA='0.0'

module load r
module load anaconda
module load tensorflow
pip install --user seaborn
export SRDIR=out/sampler_semi_synth
export Np=50
export OPID=12,25,28
export BASEDIR=out/semi_synth
export SDIR=${BASEDIR}/samples.000
export MDIR=${BASEDIR}/models.000
export pA=0.0
srun python simulate/semi_synth/simulate_observational.py --sampler_dir ${SRDIR} --samples_dir ${SDIR} --oracle_outcome_pid_str ${OPID} --n_patient $Np --n_day 1 --seed $SLURM_ARRAY_TASK_ID --prob_activity $pA --tc_folder out/time-correction-015
srun Rscript models/benchmarks/fpca/R_script/simulation_fpca.R ${SDIR} Baseline $Np ${OPID} $SLURM_ARRAY_TASK_ID
srun Rscript models/benchmarks/fpca/R_script/simulation_fpca.R ${SDIR} Operation $Np ${OPID} $SLURM_ARRAY_TASK_ID
srun python simulate/semi_synth/run_simulation.py --task semi-synth --sampler_dir ${SRDIR} --samples_dir ${SDIR} --output_dir ${MDIR} --oracle_outcome_pid_str ${OPID} --n_patient $Np --n_day 1 --seed $SLURM_ARRAY_TASK_ID --prob_activity $pA --tc_folder out/time-correction-015

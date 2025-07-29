#!/bin/bash
#SBATCH --account=proj16
#SBATCH --nodes=2
#SBATCH --ntasks=80
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=0
#SBATCH --time=08:00:00
#SBATCH --partition=prod
#SBATCH: --exclusive
#SBATCH --constraint=volta
#SBATCH --exclude=ldir01u01

cnrn_input="$1"
module_suffix="$2"
acc_sync="$3"
hip_prefix=/gpfs/bbp.cscs.ch/project/proj16/NEURONFrontiers2021/hippocampus
cnrn_input_conf="${hip_prefix}/generate_coreneuron_input/${cnrn_input}/output/sim.conf"
module purge
module use ${hip_prefix}/spack/share/spack/modules/linux-rhel7-x86_64
neurodamus_version=neurodamus-hippocampus/1.5.0.20211008-3.3.2
module load unstable ${neurodamus_version}-gpu${module_suffix}
working_dir="${hip_prefix}/run_coreneuron_simulation/${SLURM_JOBID}-gpu${module_suffix}-${acc_sync}"
mkdir -p "${working_dir}"
cd "${working_dir}"
cp ${hip_prefix}/run_coreneuron_simulation/{special-core-with-mps,setup_caliper}.sh .
module list
. setup_caliper.sh
echo Launching CoreNEURON on GPU using input config ${cnrn_input_conf}
if [[ ${acc_sync} == "synchronous" ]]
then
  export NVCOMPILER_ACC_SYNCHRONOUS=1
elif [[ ${acc_sync} == "asynchronous" ]]
then
  export NVCOMPILER_ACC_SYNCHRONOUS=0
else
  echo "Unknown value for 3rd argument: ${acc_sync}"
fi
srun ./special-core-with-mps.sh --read-config "${cnrn_input_conf}" --outpath . --cell-permute=2 --gpu --nwarp 2048
augment_caliper_json ${neurodamus_version} gpu${module_suffix}-${acc_sync} "${working_dir}" "${cnrn_input_conf}"
mv ../slurm-${SLURM_JOBID}.out .

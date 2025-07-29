#!/bin/bash
#SBATCH --account=proj16
#SBATCH --nodes=2
#SBATCH --ntasks=80
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=0
#SBATCH --time=08:00:00
#SBATCH --partition=prod
#SBATCH: --exclusive
#SBATCH --constraint=cpu&clx

spack_prefix=/gpfs/bbp.cscs.ch/project/proj16/NEURONFrontiers2021/hippocampus
module purge
module use ${spack_prefix}/spack/opt/spack/modules/tcl/linux-rhel7-x86_64
module load unstable olfactory-bulb-3d/0.1.20211014
olfactory_prefix="$(pwd)/.."
working_dir="${olfactory_prefix}/olfactory-bulb-3d/sim"
output_dir="${olfactory_prefix}/run_neuron_simulation/${SLURM_JOBID}"
mkdir -p "${output_dir}"
cd $working_dir
srun dplace special -mpi -python bulb3dtest.py --tstop=1050 --filename="nrn_cpu" |& tee "${output_dir}/NRN.log"
cat nrn_cpu.spikes* | sort -k 1n,1n -k 2n,2n > "${output_dir}/NRN.spk"
rm nrn_cpu.*

#!/bin/bash
#FLUX: --job-name=confused-citrus-3206
#FLUX: -N=2
#FLUX: -n=80
#FLUX: -c=2
#FLUX: --exclusive
#FLUX: --queue=prod
#FLUX: -t=28800
#FLUX: --priority=16

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

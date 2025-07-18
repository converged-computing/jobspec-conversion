#!/bin/bash
#FLUX: --job-name=bricky-itch-6957
#FLUX: -N=2
#FLUX: -n=80
#FLUX: -c=2
#FLUX: --exclusive
#FLUX: --queue=prod
#FLUX: -t=28800
#FLUX: --urgency=16

netpyne_m1_prefix="$(pwd)/.."
module purge
spack_prefix=/gpfs/bbp.cscs.ch/project/proj16/NEURONFrontiers2021/hippocampus
module use ${spack_prefix}/spack/opt/spack/modules/tcl/linux-rhel7-x86_64
module load unstable netpyne-m-one/0.1-20211206
output_dir="${netpyne_m1_prefix}/run_neuron_simulation/${SLURM_JOBID}"
rm -rf ${output_dir}
working_dir_prefix="$(pwd)"
cp -r ${netpyne_m1_prefix}/M1 ${working_dir_prefix}
working_dir="${working_dir_prefix}/M1/sim"
mkdir -p "${output_dir}"
cd "${working_dir}"
sed -i "s#cfg.coreneuron = .*#cfg.coreneuron = False#g" cfg.py
SIM_TIME="1000"
sed -i "s#cfg.duration = .*#cfg.duration = $SIM_TIME#g" cfg.py
srun dplace special -mpi -python init.py |& tee "${output_dir}/NRN.log"
cat out_neuron.dat | sort -k 1n,1n -k 2n,2n > "${output_dir}/NRN.spk"
rm out_neuron.dat

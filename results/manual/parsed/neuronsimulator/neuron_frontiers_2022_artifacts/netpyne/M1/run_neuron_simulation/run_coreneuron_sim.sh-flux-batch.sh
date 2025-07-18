#!/bin/bash
#FLUX: --job-name=red-mango-5267
#FLUX: -N=2
#FLUX: -n=80
#FLUX: -c=2
#FLUX: --exclusive
#FLUX: --queue=prod
#FLUX: -t=28800
#FLUX: --urgency=16

export CORENEURONLIB='/gpfs/bbp.cscs.ch/project/proj16/NEURONFrontiers2021/hippocampus/spack/opt/spack/linux-rhel7-x86_64/intel-19.1.2.254/netpyne-m-one-0.1-20211206-hnwmgj/x86_64/libcorenrnmech.so'

netpyne_m1_prefix="$(pwd)/.."
module purge
spack_prefix=/gpfs/bbp.cscs.ch/project/proj16/NEURONFrontiers2021/hippocampus
module use ${spack_prefix}/spack/opt/spack/modules/tcl/linux-rhel7-x86_64
module load unstable netpyne-m-one/0.1-20211206
output_dir="${netpyne_m1_prefix}/run_neuron_simulation/${SLURM_JOBID}-coreneuron-direct"
rm -rf ${output_dir}
working_dir_prefix="$(pwd)"
cp -r ${netpyne_m1_prefix}/M1 ${working_dir_prefix}
working_dir="${working_dir_prefix}/M1/sim"
mkdir -p "${output_dir}"
cd "${working_dir}"
sed -i "s#cfg.coreneuron = .*#cfg.coreneuron = True#g" cfg.py
SIM_TIME="1000"
sed -i "s#cfg.duration = .*#cfg.duration = $SIM_TIME#g" cfg.py
export CORENEURONLIB=/gpfs/bbp.cscs.ch/project/proj16/NEURONFrontiers2021/hippocampus/spack/opt/spack/linux-rhel7-x86_64/intel-19.1.2.254/netpyne-m-one-0.1-20211206-hnwmgj/x86_64/libcorenrnmech.so
srun dplace special -mpi -python init.py |& tee "${output_dir}/CNRN_direct.log"
cat out_neuron.dat | sort -k 1n,1n -k 2n,2n > "${output_dir}/CNRN_direct.spk"
rm out_neuron.dat

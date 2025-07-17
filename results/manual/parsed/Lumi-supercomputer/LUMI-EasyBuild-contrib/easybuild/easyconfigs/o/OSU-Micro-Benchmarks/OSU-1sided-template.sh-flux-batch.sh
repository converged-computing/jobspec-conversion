#!/bin/bash
#FLUX: --job-name=OSU-1sided
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=standard
#FLUX: -t=600
#FLUX: --urgency=16

echo -e "Case run:\n"
cat $0
echo -e "\n\n##########\n\n"
ml LUMI/%toolchainversion% partition/C
ml lumi-CPEtools/%CPEtoolsversion%-%toolchain%-%toolchainversion%%suffix%
ml OSU-Micro-Benchmarks/%OSUversion%-%toolchain%-%toolchainversion%%suffix%%cleanup%
echo -e "\nLoaded modules:\n"
module list 2>&1
echo -e "\n##########\n\nSingle-threaded tests between nodes:\n"
srun -n 2 -c 1 --ntasks-per-node=1 mpi_check -r
echo -e "\nSingle-threaded tests in a node:\n"
srun -N 1 -n 2 -c 1 mpi_check -r
echo -e "\nOSU one-sided put latency test osu_put_latency between nodes:\n"
srun -n 2 -c 1 --ntasks-per-node=1 osu_put_latency
echo -e "\nOSU one-sided put latency test osu_put_latency in a node:\n"
srun -N 1 -n 2 -c 1 osu_put_latency
echo -e "\nOSU one-sided get latency test osu_get_latency between nodes:\n"
srun -n 2 -c 1 --ntasks-per-node=1 osu_get_latency
echo -e "\nOSU one-sided get latency test osu_get_latency in a node:\n"
srun -N 1 -n 2 -c 1 osu_get_latency
echo -e "\nOSU one-sided put bandwidth test osu_put_bw between nodes:\n"
srun -n 2 -c 1 --ntasks-per-node=1 osu_put_bw
echo -e "\nOSU one-sided put bandwidth test osu_put_bw in a node:\n"
srun -N 1 -n 2 -c 1 osu_put_bw
echo -e "\nOSU one-sided get bandwidth test osu_get_bw between nodes:\n"
srun -n 2 -c 1 --ntasks-per-node=1 osu_get_bw
echo -e "\nOSU one-sided get bandwidth test osu_get_bw in a node:\n"
srun -N 1 -n 2 -c 1 osu_get_bw
echo -e "\nOSU one-sided put bidirectional bandwidth test osu_put_bibw between nodes:\n"
srun -n 2 -c 1 --ntasks-per-node=1 osu_put_bibw
echo -e "\nOSU one-sided put bidirectional bandwidth test osu_put_bibw in a node:\n"
srun -N 1 -n 2 -c 1 osu_put_bibw
echo -e "\nOSU one-sided latency test for accumulate with active/passive synchronisation osu_acc_latency between nodes:\n"
srun -n 2 -c 1 --ntasks-per-node=1 osu_acc_latency
echo -e "\nOSU one-sided latency test for accumulate with active/passive synchronisation osu_acc_latency in a node:\n"
srun -N 1 -n 2 -c 1 osu_acc_latency
echo -e "\nOSU one-sided latency test for compare and swap with active/passive synchronisation osu_cas_latency between nodes:\n"
srun -n 2 -c 1 --ntasks-per-node=1 osu_cas_latency
echo -e "\nOSU one-sided latency test for compare and swap with active/passive synchronisation osu_cas_latency in a node:\n"
srun -N 1 -n 2 -c 1 osu_cas_latency
echo -e "\nOSU one-sided latency test for fetch and op with active/passive synchronisation osu_fop_latency between nodes:\n"
srun -n 2 -c 1 --ntasks-per-node=1 osu_fop_latency
echo -e "\nOSU one-sided latency test for fetch and op with active/passive synchronisation osu_fop_latency in a node:\n"
srun -N 1 -n 2 -c 1 osu_fop_latency
echo -e "\nOSU one-sided latency test for get_accumulate with active/passive synchronisation osu_get_acc_latency between nodes:\n"
srun -n 2 -c 1 --ntasks-per-node=1 osu_get_acc_latency
echo -e "\nOSU one-sided latency test for get_accumulate with active/passive synchronisation osu_get_acc_latency in a node:\n"
srun -N 1 -n 2 -c 1 osu_get_acc_latency

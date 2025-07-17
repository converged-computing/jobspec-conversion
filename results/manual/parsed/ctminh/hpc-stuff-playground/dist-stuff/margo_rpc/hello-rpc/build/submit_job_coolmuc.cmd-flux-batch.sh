#!/bin/bash
#FLUX: --job-name=rpc_margo_test
#FLUX: -N=2
#FLUX: --queue=cm2_tiny
#FLUX: -t=120
#FLUX: --urgency=16

module load slurm_setup
module use ~/.modules
module load local-spack
module use ~/local_libs/spack/share/spack/modules/linux-sles15-haswell
module load argobots-1.0-gcc-7.5.0-x75podl
module load boost-1.75.0-gcc-7.5.0-xdru65d
module load cereal-1.3.0-gcc-7.5.0-jwb3bux
module load libfabric-1.11.1-gcc-7.5.0-p6j52ik
module load mercury-2.0.0-gcc-7.5.0-z55j3mp
module load mochi-abt-io-0.5.1-gcc-7.5.0-w7nm5r2
module load mochi-margo-0.9.1-gcc-7.5.0-n2p7v3n
module load mochi-thallium-0.8.4-gcc-7.5.0-u5zn3qg
module load hcl-dev
echo "1. Checking assigned nodes for this job..."
scontrol show hostname ${SLURM_JOB_NODELIST} > nodelist.txt
nodelist_file="./nodelist.txt"
i=0
while IFS= read -r line
do  
    node_arr[$i]=$line
    let "i++"
done < "${nodelist_file}"
echo "2. Init the server on the 1st node..."
echo "   mpirun -n 1 --host ${node_arr[0]} ./rpc_server &"
mpirun -n 1 --host ${node_arr[0]} ./rpc_server &
echo "-----[BASH-SCRIPT] Sleeping a while to let the server share addr..."
sleep 5
echo "-----[BASH-SCRIPT] Getting the server addr..."
cur_dir=$(pwd)
input_file=$(<${cur_dir}/f_server_addr.txt)
IFS=\/ read -a fields <<< $input_file
IFS=   read -a server_addr <<< $input_file
IFS=\: read -a sepa_addr <<< ${fields[2]}
echo "-----[BASH-SCRIPT] Server_IP_Addr=${sepa_addr[0]} | Port=${sepa_addr[1]}"
echo "3. Running client (just work with the margo server_addr format)..."
echo "   mpirun -n 1 --host ${node_arr[1]} ./rpc_client ${server_addr}"
mpirun -n 1 --host ${node_arr[1]} ./rpc_client ${server_addr}
echo "Done!"
echo "--------------------------------------"
echo "--------------------------------------"
rm ./nodelist.txt
rm ./f_server_addr.txt

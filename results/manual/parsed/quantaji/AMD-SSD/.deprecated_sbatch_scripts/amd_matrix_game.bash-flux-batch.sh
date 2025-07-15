#!/bin/bash
#FLUX: --job-name=forl-proj
#FLUX: -c=6
#FLUX: -t=900
#FLUX: --urgency=16

module load gcc/8.2.0 python_gpu/3.10.4 cuda/11.8.0 git-lfs/2.3.0 git/2.31.1 eth_proxy cudnn/8.4.0.27
source "${SCRATCH}/.python_venv/forl-proj/bin/activate"
ray_temp_dir="${SCRATCH}/.tmp_ray"
if [ ! -d ${ray_temp_dir} ]; then
    mkdir ${ray_temp_dir}
fi
redis_password=$(uuidgen)
export redis_password
head_node_ip=$(srun --exact --ntasks=1 hostname --ip-address)
if [[ "$head_node_ip" == *" "* ]]; then
    IFS=' ' read -ra ADDR <<<"$head_node_ip"
    if [[ ${#ADDR[0]} -gt 16 ]]; then
        head_node_ip=${ADDR[1]}
    else
        head_node_ip=${ADDR[0]}
    fi
    echo "IPV6 address detected. We split the IPV4 address as $head_node_ip"
fi
port=6379
ip_head=$head_node_ip:$port
export ip_head
echo "IP Head: $ip_head"
echo "STARTING HEAD"
srun ray start --head --node-ip-address=$head_node_ip --port=$port --redis-password=$redis_password --temp-dir $ray_temp_dir --block --disable-usage-stats &
echo "STARTING ALGORITHM with num of works of $worker_num ."
python sbatch_scripts/amd_matrix_game.py

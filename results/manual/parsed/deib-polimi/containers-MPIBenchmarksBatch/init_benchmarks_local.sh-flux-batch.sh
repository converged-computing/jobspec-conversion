#!/bin/bash
#FLUX: --job-name=goodbye-gato-3966
#FLUX: --queue=hpc
#FLUX: -t=600
#FLUX: --urgency=16

scripts_dir=~/workspace/bench
mkdir -p $scripts_dir
echo "writing no container batch scripts"
cat << 'EOF' >> $scripts_dir/mpibench_nocont.sh
module purge
module load mpi/openmpi
mpirun --map-by node -mca pml ucx --mca btl ^vader,tcp,openib -x UCX_NET_DEVICES=mlx5_0:1 -x UCX_IB_PKEY=$UCX_IB_PKEY /home/azureuser/local_workspace/mpiBench-master/mpiBench -e $1
EOF
cat << 'EOF' >> $scripts_dir/osu_nocont.sh
module purge
module load mpi/openmpi
mpirun --map-by node -mca pml ucx --mca btl ^vader,tcp,openib -x UCX_NET_DEVICES=mlx5_0:1 -x UCX_IB_PKEY=$UCX_IB_PKEY /home/azureuser/local_workspace/osu-micro-benchmarks-5.6.3/$1 ${@:2}
EOF
echo "pulling docker containers"
sudo docker pull nichr/hpc-bench:v2
mkdir -p ~/workspace/singularity
cd ~/workspace/singularity
echo "writing sif definition file"
cat << 'EOF' >> v2.def
BootStrap: docker-daemon
From: nichr/hpc-bench:v2
EOF
echo "building sif"
sudo /usr/local/bin/singularity build v2.sif v2.def
echo "writing singularity batch scripts"
cat << 'EOF' >> $scripts_dir/mpibench_singularity.sh
module purge
module load mpi/openmpi
mpirun --map-by node -mca pml ucx --mca btl ^vader,tcp,openib -x UCX_NET_DEVICES=mlx5_0:1 -x UCX_IB_PKEY=$UCX_IB_PKEY singularity run /home/azureuser/local_workspace/singularity/v2.sif /opt/benchmarks/mpiBench/mpiBench -e $1
EOF
cat << 'EOF' >> $scripts_dir/osu_singularity.sh
module purge
module load mpi/openmpi
mpirun --map-by node -mca pml ucx --mca btl ^vader,tcp,openib -x UCX_NET_DEVICES=mlx5_0:1 -x UCX_IB_PKEY=$UCX_IB_PKEY singularity run /home/azureuser/local_workspace/singularity/v2.sif /opt/benchmarks/osu-micro-benchmarks/$1 ${@:2}
EOF
echo "building charliecloud container"
mkdir -p ~/workspace/charliecloud
cd ~/workspace/charliecloud
ch-builder2tar nichr/hpc-bench:v2 .
ch-tar2dir nichr.hpc-bench:v2.tar.gz .
echo "writing charliecloud batch scripts"
cat << 'EOF' >> $scripts_dir/mpibench_charliecloud.sh
module purge
module load mpi/openmpi
mpirun --map-by node -mca pml ucx --mca btl ^vader,tcp,openib -x UCX_NET_DEVICES=mlx5_0:1 -x UCX_IB_PKEY=$UCX_IB_PKEY ch-run --join /home/azureuser/local_workspace/charliecloud/nichr.hpc-bench\:v2 -- /opt/benchmarks/mpiBench/mpiBench -e $1
EOF
cat << 'EOF' >> $scripts_dir/osu_charliecloud.sh
module purge
module load mpi/openmpi
mpirun --map-by node -mca pml ucx --mca btl ^vader,tcp,openib -x UCX_NET_DEVICES=mlx5_0:1 -x UCX_IB_PKEY=$UCX_IB_PKEY ch-run --join /home/azureuser/local_workspace/charliecloud/nichr.hpc-bench\:v2 -- /opt/benchmarks/osu-micro-benchmarks/$1 ${@:2}
EOF
echo "copy files to local folders"
cat << 'EOF' >> $scripts_dir/copy.sh
srun mkdir -p /home/azureuser/local_workspace/
srun cp -R /home/azureuser/workspace/mpiBench-master/ /home/azureuser/workspace/osu-micro-benchmarks-5.6.3/ /home/azureuser/workspace/singularity/ /home/azureuser/local_workspace/
srun mkdir -p /home/azureuser/local_workspace/charliecloud/
srun ch-tar2dir /home/azureuser/workspace/charliecloud/nichr.hpc-bench:v2.tar.gz /home/azureuser/local_workspace/charliecloud
EOF
sbatch --job-name copy \
	   --nodes $1 \
	   --cpus-per-task 1 \
	   --output=$scripts_dir/res_copy.txt \
	   --err=$scripts_dir/err_copy.txt \
	   $scripts_dir/copy.sh

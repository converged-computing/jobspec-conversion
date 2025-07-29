#!/bin/bash
#SBATCH --job-name=Benchmark_kseqpp_read
#SBATCH --account=dongelr1
#SBATCH --output=out.txt
#SBATCH --error=err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:a100:0,nvme:300
#SBATCH --mem=3G
#SBATCH --time=00:15:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1

export OLD_PWD='${PWD}'
export NEW_PWD='${LOCAL_SCRATCH}/tmp'

module purge
module load cmake gcc bzip2 git
export OLD_PWD="${PWD}"
export NEW_PWD="${LOCAL_SCRATCH}/tmp"
cp -r . "${NEW_PWD}"
cd "${NEW_PWD}"
sh scripts/build.sh
./build/bin/benchmark

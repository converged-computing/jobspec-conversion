#!/bin/bash
#SBATCH --output=slurm/slurm.%N.%j.out
#SBATCH --error=slurm/slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=1-00:00:00
#SBATCH --partition=shared

dataverse="harvard"            # harvard or demo
singularity_within_snakemake=1 # 1 or 0
upload=0                       # 1 or 0
if [ $dataverse == "harvard" ]; then
    token=$HARVARD_DATAVERSE_TOKEN
elif [ $dataverse == "demo" ]; then
    token=$DEMO_DATAVERSE_TOKEN
else
    echo "Dataverse not recognized. Please use harvard or demo."
    exit 1
fi
job="snakemake --rerun-incomplete --nolock --use-singularity"
slurm_options="/usr/bin/sbatch --ntasks {cluster.ntasks} -N {cluster.N} -t {cluster.t} \
    --cpus-per-task {cluster.cpus_per_task} -p {cluster.p} --mem {cluster.mem} -o {cluster.output} \
    -e {cluster.error} --mail-type={cluster.mail_type}"
options="--configfile conf/pipeline.yaml -C upload=$upload token=$token upload_dataverse=$dataverse"
$job $options --cluster "${slurm_options}" --cluster-config conf/cluster.yaml -j 12

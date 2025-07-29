#!/bin/bash
#SBATCH --job-name=orthomcl
#SBATCH --mail-user=useremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=04:00:00

module load singularity
module load orthomcl
cd ~/bigdata/mysql
PORT=$(singularity exec --writable-tmpfs -B db/:/var/lib/mysql mariadb.sif grep -oP '^port = \K\d{4}' /etc/mysql/my.cnf | head -1)
singularity instance start --writable-tmpfs -B db/:/var/lib/mysql mariadb.sif mysqldb
sleep 10
cd ~/bigdata/
sed -i "s/^dbConnectString.*$/dbConnectString=dbi:mysql:orthomcl:${HOSTNAME}:${PORT}/" orthomcl/orthomcl.config
orthomclInstallSchema orthomcl/orthomcl.config orthomcl/install_schema.log
singularity instance stop mysqldb

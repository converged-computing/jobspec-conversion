#!/bin/bash
#FLUX: --job-name=orthomcl
#FLUX: -t=14400
#FLUX: --urgency=16

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

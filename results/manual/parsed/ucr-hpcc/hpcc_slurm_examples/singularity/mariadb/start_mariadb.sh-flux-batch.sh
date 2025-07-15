#!/bin/bash
#FLUX: --job-name=expressive-earthworm-8463
#FLUX: -t=604800
#FLUX: --priority=16

module load singularity
cd ~/bigdata/mysql/
PORT=$(singularity exec --writable-tmpfs -B db/:/var/lib/mysql mariadb.sif grep -oP '^port = \K\d{4}' /etc/mysql/my.cnf | head -1)
echo $HOSTNAME $PORT > db_host_port.txt
singularity exec --writable-tmpfs -B db/:/var/lib/mysql mariadb.sif /usr/bin/mysqld_safe

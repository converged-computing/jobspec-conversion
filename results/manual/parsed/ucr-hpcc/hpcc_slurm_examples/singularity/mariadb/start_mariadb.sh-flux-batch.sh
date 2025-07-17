#!/bin/bash
#FLUX: --job-name=stinky-destiny-3451
#FLUX: -c=2
#FLUX: --queue=batch,intel
#FLUX: -t=604800
#FLUX: --urgency=16

module load singularity
cd ~/bigdata/mysql/
PORT=$(singularity exec --writable-tmpfs -B db/:/var/lib/mysql mariadb.sif grep -oP '^port = \K\d{4}' /etc/mysql/my.cnf | head -1)
echo $HOSTNAME $PORT > db_host_port.txt
singularity exec --writable-tmpfs -B db/:/var/lib/mysql mariadb.sif /usr/bin/mysqld_safe

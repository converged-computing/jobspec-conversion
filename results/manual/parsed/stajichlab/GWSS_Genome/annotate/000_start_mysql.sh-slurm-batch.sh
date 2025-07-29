#!/bin/bash
#SBATCH --job-name=mysqld
#SBATCH --output=logs/mysql.log
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32gb
#SBATCH --time=7-00:00:00

export SINGULARITY_BINDPATH='bigdata'
export SINGULARITYENV_PASACONF='pasa.config.txt'

PROGNAME=$(basename $0)
module load singularity
stop_mysqldb() { singularity instance stop mysqldb; }
trap "stop_mysqldb; exit 130" SIGHUP SIGINT SIGTERM
error_exit()
{
    stop_mysqldb
	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}
export SINGULARITY_BINDPATH=bigdata
export SINGULARITYENV_PASACONF=pasa.config.txt
cd ~/bigdata/mysql
PORT=$(singularity exec --writable-tmpfs -B db/:/var/lib/mysql mariadb.sif grep -oP '^port = \K\d{4}' /etc/mysql/my.cnf | head -1)
echo $PORT
sed -i "s/^MYSQLSERVER.*$/MYSQLSERVER=${HOSTNAME}:${PORT}/" ${SINGULARITYENV_PASACONF}
singularity exec --writable-tmpfs -B db/:/var/lib/mysql mariadb.sif /usr/bin/mysqld_safe
stop_mysqldb
exit 0

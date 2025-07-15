#!/bin/bash
#FLUX: --job-name=test
#FLUX: -N=2
#FLUX: --queue=q1
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/local/lib'

set -e
. "/etc/parallelcluster/cfnconfig"
case "${cfn_node_type}" in
    ComputeFleet)
        yum install -y htop
        exit 0
    ;;
    *)
    ;;
esac
/opt/parallelcluster/scripts/imds/imds-access.sh --allow slurm
PCLUSTER_RDS_HOST="$1"
PCLUSTER_RDS_PORT="$2"
PCLUSTER_RDS_USER="$3"
PCLUSTER_RDS_PASS="$4"
PCLUSTER_NAME="$5"
REGION="$6"
FEDERATION_NAME="$8"
host_name=$(hostname)
CORES=$(grep processor /proc/cpuinfo | wc -l)
lower_name=$(echo $PCLUSTER_NAME | tr '[:upper:]' '[:lower:]')
yum update -y
sed -i 's/ClusterName=parallelcluster/ClusterName='$lower_name'/g' /opt/slurm/etc/slurm.conf
rm -rf /var/spool/slurm.state/* || true
yum install –y epel-release
yum-config-manager --enable epel
yum install -y hdf5-devel
yum install -y libyaml http-parser-devel json-c-devel
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
cat > /etc/ld.so.conf.d/slurmrestd.conf <<EOF
/usr/local/lib
/usr/local/lib64
EOF
cd /shared
wget http://repo.openfusion.net/centos7-x86_64/libjwt-1.9.0-1.of.el7.x86_64.rpm
rpm -Uvh libjwt-1.9.0-1.of.el7.x86_64.rpm
wget http://repo.openfusion.net/centos7-x86_64/libjwt-devel-1.9.0-1.of.el7.x86_64.rpm
rpm -Uvh libjwt-devel-1.9.0-1.of.el7.x86_64.rpm 
source /opt/parallelcluster/pyenv/versions/cookbook_virtualenv/bin/activate
cd /shared
slurm_version=20.11.8
wget https://download.schedmd.com/slurm/slurm-${slurm_version}.tar.bz2
tar xjf slurm-${slurm_version}.tar.bz2
cd slurm-${slurm_version}
./configure --prefix=/opt/slurm --with-pmix=/opt/pmix
make -j $CORES
make install
make install-contrib
deactivate
openssl genrsa -out /var/spool/slurm.state/jwt_hs256.key 2048
chown slurm /var/spool/slurm.state/jwt_hs256.key
chmod 0700 /var/spool/slurm.state/jwt_hs256.key
cat >>/opt/slurm/etc/slurm.conf<<EOF
AuthAltTypes=auth/jwt
JobAcctGatherType=jobacct_gather/linux
JobAcctGatherFrequency=30
AccountingStorageType=accounting_storage/slurmdbd
AccountingStorageHost=${host_name} # cluster headnode's DNS
AccountingStorageUser=${PCLUSTER_RDS_USER}
AccountingStoragePort=6839
EOF
cat >/opt/slurm/etc/slurmdbd.conf<<EOF
ArchiveEvents=yes
ArchiveJobs=yes
ArchiveResvs=yes
ArchiveSteps=no
ArchiveSuspend=no
ArchiveTXN=no
ArchiveUsage=no
AuthType=auth/munge
DbdHost="${host_name}" #YOUR_MASTER_IP_ADDRESS_OR_NAME
DbdPort=6839
DebugLevel=info
PurgeEventAfter=1month
PurgeJobAfter=12month
PurgeResvAfter=1month
PurgeStepAfter=1month
PurgeSuspendAfter=1month
PurgeTXNAfter=12month
PurgeUsageAfter=24month
SlurmUser=slurm
LogFile=/var/log/slurmdbd.log
PidFile=/var/run/slurmdbd.pid
StorageType=accounting_storage/mysql
StorageUser=${PCLUSTER_RDS_USER}
StoragePass=${PCLUSTER_RDS_PASS}
StorageHost=${PCLUSTER_RDS_HOST} # Endpoint from RDS console
StoragePort=${PCLUSTER_RDS_PORT}
EOF
chown slurm /opt/slurm/etc/slurmdbd.conf 
chmod 600 /opt/slurm/etc/slurmdbd.conf
cat >/opt/slurm/etc/slurmrestd.conf<<EOF
include /opt/slurm/etc/slurm.conf
AuthType=auth/jwt
EOF
/opt/slurm/sbin/slurmdbd
cat >/etc/systemd/system/slurmrestd.service<<EOF
[Unit]
Description=Slurm restd daemon
After=network.target slurmctl.service
ConditionPathExists=/opt/slurm/etc/slurmrestd.conf
[Service]
Environment=SLURM_CONF=/opt/slurm/etc/slurmrestd.conf
ExecStart=/opt/slurm/sbin/slurmrestd -vvvv 0.0.0.0:8082 -u slurm
PIDFile=/var/run/slurmrestd.pid
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl start slurmrestd
systemctl restart slurmctld
cat >/shared/token_refresher.sh<<EOF
export \$(/opt/slurm/bin/scontrol token -u slurm)
aws secretsmanager describe-secret --secret-id slurm_token_${PCLUSTER_NAME} --region $REGION
if [ \$? -eq 0 ]
then
 aws secretsmanager update-secret --secret-id slurm_token_${PCLUSTER_NAME} --secret-string "\$SLURM_JWT" --region $REGION
else
 aws secretsmanager create-secret --name slurm_token_${PCLUSTER_NAME} --secret-string "\$SLURM_JWT" --region $REGION
fi
EOF
chmod +x /shared/token_refresher.sh
cat >/etc/cron.d/slurm-token<<EOF
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root
*/20 * * * * root /shared/token_refresher.sh 
EOF
mkdir -p /shared/tmp
chown slurm:slurm /shared/tmp
cat >/shared/tmp/fetch_and_run.sh<<EOF
PATH="/bin:/usr/bin/:/usr/local/bin/:/opt/slurm/bin:/opt/amazon/openmpi/bin"
LD_LIBRARY_PATH="/lib/:/lib64/:/usr/local/lib:/opt/slurm/lib:/opt/slurm/lib64"
error_exit () {
  echo "Fetch and run error - \${1}" >&2
  exit 1
}
which aws >/dev/null 2>&1 || error_exit "Please install AWS CLI first."
mkdir -p \$5
cd \$5
aws s3 cp "s3://\$1/\$2/\$3" \$3
aws s3 cp "s3://\$1/\$2/\$4" \$4
chmod +x \$4
sbatch \$4
EOF
chmod +x /shared/tmp/fetch_and_run.sh
/shared/token_refresher.sh 
if [ $FEDERATION_NAME ]
then
    # store the munge.key in secret manager so the other cluster can use it, ignore if it doesn't exist
    aws secretsmanager delete-secret --secret-id munge_key_$FEDERATION_NAME --force-delete-without-recovery --region $REGION | true
    aws secretsmanager create-secret --name munge_key_$FEDERATION_NAME --secret-binary fileb:///etc/munge/munge.key --region $REGION
fi
systemctl restart slurmctld
cat >/shared/tmp/batch_test.sh <<EOF
cd /shared/tmp
srun hostname
srun sleep 60
EOF
chown slurm /shared/tmp/batch_test.sh

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
if [ $7 == 'localhost' ]
then
  host_name=$(hostname)
else
  host_name="$7"
fi
CORES=$(grep processor /proc/cpuinfo | wc -l)
lower_name=$(echo $PCLUSTER_NAME | tr '[:upper:]' '[:lower:]')
yum update -y
sed -i 's/ClusterName=parallelcluster/ClusterName='$lower_name'/g' /opt/slurm/etc/slurm.conf
rm /var/spool/slurm.state/*
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
rpm -Uvh libjwt-1.9.0-1.of.el7.x86_64.rpm || true
wget http://repo.openfusion.net/centos7-x86_64/libjwt-devel-1.9.0-1.of.el7.x86_64.rpm
rpm -Uvh libjwt-devel-1.9.0-1.of.el7.x86_64.rpm || true
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
AccountingStoragePort=6839
EOF
if [ $FEDERATION_NAME ]
then
    # store the munge.key in secret manager so the other cluster can use it
    aws secretsmanager get-secret-value --secret-id munge_key_$FEDERATION_NAME --region $REGION --query 'SecretBinary' |tr -d '"'| base64 --decode > /etc/munge/munge.key
    cp /etc/munge/munge.key /home/ec2-user/.munge/.munge.key
fi
systemctl daemon-reload
systemctl restart munge
systemctl restart slurmctld
mkdir -p /shared/tmp
chown slurm /shared/tmp
cat <<EOF>/shared/tmp/batch_test.sh
cd /shared/tmp
srun hostname
srun sleep 60
EOF
chown slurm /shared/tmp/batch_test.sh

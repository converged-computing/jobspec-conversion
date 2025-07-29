#!/bin/bash
#SBATCH --mail-user=dsu@princeton.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=20000
#SBATCH --time=02:10:00
#SBATCH --constraint=ntasks-per-node=4,ntasks-per-socket=2

export PATH='$PATH:/usr/lib/jvm/java-1.8.0-openjdk'
export JAVA_HOME='/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64/'
export LD_LIBRARY_PATH='/usr/lib/jvm/jre/lib/amd64:$LD_LIBRARY_PATH'

export PATH=$PATH:/usr/lib/jvm/java-1.8.0-openjdk
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64/
export LD_LIBRARY_PATH=/usr/lib/jvm/jre/lib/amd64:$LD_LIBRARY_PATH
python main.py

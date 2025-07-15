#!/bin/bash
#FLUX: --job-name=expressive-bits-4832
#FLUX: --urgency=16

export PATH='$PATH:/usr/lib/jvm/java-1.8.0-openjdk'
export JAVA_HOME='/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64/'
export LD_LIBRARY_PATH='/usr/lib/jvm/jre/lib/amd64:$LD_LIBRARY_PATH'

export PATH=$PATH:/usr/lib/jvm/java-1.8.0-openjdk
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64/
export LD_LIBRARY_PATH=/usr/lib/jvm/jre/lib/amd64:$LD_LIBRARY_PATH
python main.py

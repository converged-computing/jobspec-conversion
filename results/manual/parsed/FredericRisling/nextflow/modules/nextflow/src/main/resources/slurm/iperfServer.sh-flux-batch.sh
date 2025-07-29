#!/bin/bash
#FLUX --job-name=spicy-lamp-9869
#FLUX -t=1200
#FLUX --urgency=16

srun iperf -s

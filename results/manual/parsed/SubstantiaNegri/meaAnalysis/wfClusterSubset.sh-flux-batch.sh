#!/bin/bash
#FLUX: --job-name=dirty-leopard-3507
#FLUX: --urgency=16

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
minimum=10
superactive_count=5000
shortMax=720 # 12hr in minutes
medMax=7200 # 5days in minutes
longMax=43200 # 30days in minutes
echo 'node' 'line_count' > inactive_nodes.txt
echo 'node' 'line_count' > active_nodes.txt
echo 'node' 'line_count' > superactive_nodes.txt
for f in $(ls *.csv) 
	do
	line_count=$(wc -l $f | cut -f1 -d' ')
		if [ "$line_count" -le "$minimum" ]
		then
			echo "${f%.csv}" $line_count >> inactive_nodes.txt
		elif [ "$line_count" -le "$superactive_count" ]
		then
			echo $f
			echo "${f%.csv}" $line_count >> active_nodes.txt
			jobtime=$(perl ~/scripts/msClusterLineCountTimeCalc.pl $line_count)
				if [ "$jobtime" -le "$shortMax" ]
					then
					sbatch -p short -t $jobtime -n 12 --mem=1G ~/scripts/R-3.4.1/msCluster.R $f 12
				elif [ "$jobtime" -le "$medMax" ]
					then
					sbatch -p medium -t $jobtime -n 12 --mem=1G ~/scripts/R-3.4.1/msCluster.R $f 12
				else
					sbatch -p long -t $jobtime -n 12 --mem=1G ~/scripts/R-3.4.1/msCluster.R $f 12
				fi
		else
			echo "${f%.csv}" $line_count >> superactive_nodes.txt
			sed 1q $f > sampled_$f
			sed -i 1d $f
			shuf -n $superactive_count $f >> sampled_$f
			jobtime=$(perl ~/scripts/msClusterLineCountTimeCalc.pl $superactive_count)
			if [ "$jobtime" -le "$shortMax" ]
					then
					sbatch -p short -t $jobtime -n 12 --mem=1G ~/scripts/R-3.4.1/msCluster.R sampled_$f 12
				elif [ "$jobtime" -le "$medMax" ]
					then
					sbatch -p medium -t $jobtime -n 12 --mem=1G ~/scripts/R-3.4.1/msCluster.R sampled_$f 12
				else
					sbatch -p long -t $jobtime -n 12 --mem=1G ~/scripts/R-3.4.1/msCluster.R sampled_$f 12
				fi
		fi
	done; 

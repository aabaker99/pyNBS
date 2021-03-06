#! /bin/bash


################################################################################################
# Use this shell script to generate the an example pyNBS command line call
# Change the file paths and values of parameters desired to change
# Use the line printed to stdout after executing the script with your changes
# For additional information on the pyNBS Pythton script, please see our GitHub Wiki:
# https://github.com/huangger/pyNBS/wiki/pyNBS-Command-Line-Manual
# This example assumes the user is in the ~/Examples folder of the pyNBS repository
################################################################################################

################################################################################################
# Set required parameters for pyNBS
# All parameter values in this block are required
echo '-------------'
# ----------
# Set to the location of the 'run_pyNBS.py' script
pyNBS_script='./run_pyNBS.py'
echo 'Python Script: '$pyNBS_script

# This is the file path to the binary somatic mutation data file
# For information on the somatic mutation data file, please visit:
# https://github.com/huangger/pyNBS/wiki/Somatic-Mutation-Data-File-Format
mutation_file='./Example_Data/Mutation_Files/BLCA_sm_data.txt'
echo 'Somatic Mutation Data File: '$mutation_file

# This is the file path to the network file
# For information on the network file, please visit:
# https://github.com/huangger/pyNBS/wiki/Molecular-Network-File-Format
network_file='./Example_Data/Network_Files/CancerSubnetwork.txt'	
echo 'Network File: '$network_file

# Generate pyNBS command
pyNBS_cmd='python '$pyNBS_script' '$mutation_file' '$network_file
################################################################################################


################################################################################################
# All parameter values in this block are NOT required
# If the user prefers to not set these values, please set the variable value to ""
# e.g. if the user did not want to set a params_file, the line would look like:
# params_file=""
# *** The double quotes " are required for setting values to empty! ***
# Parameters set as "" will not be included in the generate pyNBS call
# ----------
# This is the file path to the pyNBS parameters file
# For information on the parameters file, please visit:
# https://github.com/huangger/pyNBS/wiki/pyNBS-Parameters-File
params_file='./run_pyNBS_params/BLCA_run_pyNBS_params.csv'
echo 'pyNBS Parameters File: '$params_file
# ^ This file path is optional. The generator will remove the call to the '-params'
# parameter in run_pyNBS.py if the variable value is ''
if [ "$params_file" != "" ]; then
	pyNBS_cmd=$pyNBS_cmd' -params '$params_file
fi

# This is the path to the output directory to save pyNBS result files
# If the path does not exist, run_pyNBS.py will attempt to create the destination
# The default output directory when using this script will be the current working directory
# See 'outdir' parameter in the parameters file documentation for more details:
# https://github.com/huangger/pyNBS/wiki/pyNBS-Parameters-File
outdir=$PWD
echo 'Output Directory: '$outdir
if [ "$outdir" != "" ]; then
	pyNBS_cmd=$pyNBS_cmd' -o '$outdir
fi

# This is a file name prefix for all pyNBS result files from this run
job_name='pyNBS'
echo 'Job Name: '$job_name
if [ "$job_name" != "" ]; then
	pyNBS_cmd=$pyNBS_cmd' -j '$job_name
fi

# This is the network propagation coefficient alpha
# The default alpha value (if not set) is 0.7
# This is the same value as the 'alpha' value in the 'network_propagation' function:
# https://github.com/huangger/pyNBS/wiki/pyNBS.network_propagation.network_propagation
# Referred to as 'prop_alpha' in the parameters file
a=0.7
echo 'Alpha: '$a
if [ "$a" != "" ]; then
	pyNBS_cmd=$pyNBS_cmd' -a '$a
fi

# This is the number of clusters to be generated by pyNBS
# The default number of clusters (if not set) is 3
# This is the same value as 'k' in the 'mixed_netNMF' function:
# https://github.com/huangger/pyNBS/wiki/pyNBS.pyNBS_core.mixed_netNMF	
# This is also the value used as 'k' in the 'consensus_hclust_hard' function:
# https://github.com/huangger/pyNBS/wiki/pyNBS.consensus_clustering.consensus_hclust_hard
# Referred to as 'netNMF_k' in the parameters file
k=4
echo 'Nubmer of Clusters: '$k
if [ "$k" != "" ]; then
	pyNBS_cmd=$pyNBS_cmd' -k '$k
fi

# This is the number of iterations to perform the NBS algorithm for consensus clustering
# The default number of iterations (if not set) is 100
# See Step 4 in the pyNBS Algorithm description page for more details:
# https://github.com/huangger/pyNBS/wiki/The-pyNBS-Algorithm
n="5"
echo 'pyNBS Iterations: '$n
if [ "$n" != "" ]; then
	pyNBS_cmd=$pyNBS_cmd' -n '$n
fi

# This is the file path to the cohort survival data file
# If a path is given, survival analysis will automatically be attempted by run_pyNBS.py
# Otherwise, survival analysis is not performed
# For information on the survival data file, please visit:
# https://github.com/huangger/pyNBS/wiki/Patient-Survival-Data-File-Format
survival_file='./Example_Data/Clinical_Files/BLCA.clin.merged.surv.txt'
echo 'Survival Data File: '$survival_file
if [ "$survival_file" != "" ]; then
	pyNBS_cmd=$pyNBS_cmd' -surv '$survival_file
fi

# This is the number of threads to limit the pyNBS process to. The default number of threads is 2.
# If the user would like to utilize more threads (for faster execution), this value needs to be set
# The number of threads is only set for the run_pyNBS.py script and not individual functions
# The number of threads can only be set for computers with Intel processors 
threads=8
echo 'Number of threads: '$threads
if [ "$threads" != "" ]; then
	pyNBS_cmd=$pyNBS_cmd' -t '$threads
fi
################################################################################################

################################################################################################
# Print Final Python Call
echo 'pyNBS Call:'
echo $pyNBS_cmd
echo '-------------'
################################################################################################

################################################################################################
# Optional: If the user would actually like to execute the command generated by this script directly (assuming all dependencies are installed)
# The user simply needs to uncomment the following line:
# eval $pyNBS_cmd
################################################################################################

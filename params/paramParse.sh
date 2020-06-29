#!/bin/bash

usage() {
  echo "-h : display help documentation for this and exit without running.";
  echo "-f : Yaml file to be parsed and converted to Nextflow String";
  exit 99;
}

#Parse thru options
OPTIND=1;
while getopts :f:h opt; do
  case ${opt} in
    f) inFile=$OPTARG;;
    h) usage;;
  esac;
done;
shift $((OPTIND -1));

#Verify the input file exists
if [ -z "${inFile}" ]; then
  echo -e "Error: no JSON file specified for parsing, please specify using the '-f' flag";
  exit 1;
elif [ ! `echo ${inFile} | rev | cut -f1 -d '.' | rev | sed -e "s/jsn/json/g"` == "json" ]; then
  echo -e "Error: specified file does not appear to be a JSON file, please ensure the file ends in either '.jsn' or '.json'";
  exit 2;
elif [ `head -n1 ${inFile} | grep "^{"` == "" ]; then
  echo -e "Error: ${inFile} does not appear to be a properly formatted JSON file.";
  exit 3;
else inFile=`readlink -e ${inFile}`;
fi;

#Read in the json and put things in the right places.
parameters='';
SAVEIFS=${IFS};
IFS=$(echo -en "\n\b");
for line in `cat ${inFile} | grep -v "^{\|^}"`; do
  line=`echo ${line} | sed -e "s:^[\t]*::g; s:^[ ]*::g; s:[ ]*$::g; s:[\t]*$::g"`;
  parameters=`echo "\`echo -n ${parameters}\` --\`echo ${line} | cut -f1 -d ':' | tr -d '\"' | tr -d '\t'\` \`echo ${line} | cut -f2 -d ':' | tr -d '\"' | tr -d ' ' | sed -e \"s/,$//g\"\`"`;
done;
IFS=${SAVEIFS}

#Print out the nextflow command
echo -e "nextflow run workflow/main.nf ${parameters}";

FROM docker://bicf/nextflow20:latest

RUN apt update && apt install build-essential unzip pigz pv -y && apt clean
RUN pip3 install azure-cli
ADD azureblobworker.sh /opt/azureblobworker.sh
RUN chmod +x /opt/azureblobworker.sh

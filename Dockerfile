FROM nvidia/cuda:12.6.1-cudnn-devel-ubuntu24.04
RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt-get install -y python3 python3.12 python3.12-venv python3.12-dev libjpeg-dev zlib1g-dev
RUN python3 -m venv /opt/cog_video_venv
ENV PATH="/opt/cog_video_venv/bin:$PATH"
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
RUN pip install jupyter
RUN pip install torchao==0.4.0

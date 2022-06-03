FROM --platform=linux/amd64 ubuntu:20.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential git perl python3 make autoconf g++ flex bison ccache libgoogle-perftools-dev numactl perl-doc libfl2  libfl-dev zlibc zlib1g zlib1g-dev  

COPY . /repo
WORKDIR /repo
RUN autoconf
RUN ./configure
RUN make -j8

FROM --platform=linux/amd64 ubuntu:20.04 as builder

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential git perl python3 make autoconf g++ flex bison ccache libgoogle-perftools-dev numactl perl-doc libfl2  libfl-dev zlibc zlib1g zlib1g-dev clang
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y cmake

COPY . /repo
WORKDIR /repo
RUN autoconf
RUN ./configure --prefix=/install
RUN make -j8
RUN make install
ENV VERILATOR_ROOT=/repo/
WORKDIR /repo/examples/cmake_protect_lib
RUN make -j8
RUN clang++ /repo/mayhem/fuzz_VL_DBG_MSGF.cpp -fsanitize=fuzzer,address -I /repo/include/ -L /repo/examples/cmake_protect_lib/build/ -lverilated_secret -o /fuzz

FROM ubuntu:22.04 as package
COPY --from=builder /install /install
COPY --from=builder /fuzz /fuzz_VL_DBG_MSGF

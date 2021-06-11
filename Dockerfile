FROM ubuntu:20.04
ARG PARALLELISM=1

ENV IROHA_HOME /opt/iroha
ENV IROHA_BUILD /opt/iroha/build
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=US/NYC

RUN apt-get update \
  && apt-get -y --no-install-recommends install \
    tzdata \
    build-essential \
    ninja-build \
    pkg-config \
    git \
	ssh \
	tar \
	gzip \
    ca-certificates \
    curl \
    zip \
    unzip \
    cmake \
	python3-dev 

WORKDIR /opt/
RUN git clone -b master https://github.com/hyperledger/iroha --depth=1 \
&& iroha/vcpkg/build_iroha_deps.sh \
&& vcpkg/vcpkg integrate install 
WORKDIR /opt/iroha/
RUN cmake -H. -Bbuild -DCMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake -G "Ninja" 
WORKDIR /opt/iroha/build
RUN cmake --build . --target all -- -j8

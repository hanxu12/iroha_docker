FROM ubuntu:20.04

# Install iroha and iroha_shepherd
# Derived iroha.deb and iroha_shepherd.deb via official repo
#git ...

RUN set -e; apt-get update; \
    apt-get install -y netcat /tmp/iroha.deb /tmp/iroha_shepherd.deb; \
    # git clone https://github.com/hyperledger/iroha.git -b 1.2.0
    # iroha/vcpkg/build_iroha_deps.sh
    # vcpkg/vcpkg integrate install
    # cd iroha && mkdir build && cd build/
    # cmake -DCMAKE_TOOLCHAIN_FILE=/home/han/abc/vcpkg/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TYPE=Release -DPACKAGE_DEB=ON -G "Ninja" ..
    # cmake --build . --target package -- -j4
    COPY iroha.deb /tmp/iroha.deb
COPY iroha_shepherd.deb /tmp/iroha_shepherd.deb
RUN set -e; apt-get update; \
    apt-get install -y netcat /tmp/iroha.deb /tmp/iroha_shepherd.deb; \
    rm -f /tmp/iroha.deb /tmp/iroha_shepherd.deb; \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/iroha_data
COPY example/ /opt/iroha_data
COPY entrypoint.sh wait-for-it.sh /
RUN chmod +x /entrypoint.sh /wait-for-it.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["irohad"]

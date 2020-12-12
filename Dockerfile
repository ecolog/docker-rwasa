
# build

FROM scratch
MAINTAINER Oracle Linux 7 slim <vofkav@gmail.com>
ADD oraclelinux-7-slim-rootfs.tar.xz /

# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/bin/bash"]

ENV FASM_VERSION 1.73.09
ENV HEAVYTHING_VERSION 1.24

RUN apt-get --update --no-cache add binutils curl && \
	curl -sL "https://flatassembler.net/fasm-$FASM_VERSION.tgz" | tar xz && \
	ln -s /fasm/fasm /bin/fasm

WORKDIR /build

COPY build.sh ./build.sh

RUN chmod +x ./build.sh
RUN ./build.sh $HEAVYTHING_VERSION

# release

FROM scratch
LABEL maintainer "Scott Mathieson <scttmthsn@gmail.com>"

COPY root /
COPY --from=builder /build/rwasa /

ENTRYPOINT ["/rwasa"]

CMD ["-bind", "8080", "-foreground", "-sandbox", "/var/www"]

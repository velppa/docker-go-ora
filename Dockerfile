FROM golang:1.15

ADD distrib /distrib

ENV VERSION="19.8.0.0.0dbru" \
    POSTFIX="19_8" \
    VER="19.8"

ENV ORACLE_HOME=/usr/lib/oracle/instantclient_$POSTFIX \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/oracle/instantclient_$POSTFIX \
    PATH=$PATH:/usr/lib/oracle/instantclient_$POSTFIX

RUN apt-get update && \
    apt-get -y install zip libaio1 && \
    ls /distrib && \
    unzip /distrib/instantclient-basic-linux.x64-$VERSION.zip -d /usr/lib/oracle && \
    unzip /distrib/instantclient-sdk-linux.x64-$VERSION.zip -d /usr/lib/oracle && \
    unzip /distrib/instantclient-sqlplus-linux.x64-$VERSION.zip -d /usr/lib/oracle && \
    rm -rf /distrib

COPY oci8.pc /usr/local/lib/pkgconfig/oci8.pc

# add alias to go so we don't need to provide compilation flags every time
# not needed for 19.3
#RUN ln -s $(find $ORACLE_HOME -name 'libclntsh.so.*' | head -n 1) $ORACLE_HOME/libclntsh.so

RUN go get github.com/mattn/go-oci8

#RUN echo 'alias go="CGO_LDFLAGS=-L$ORACLE_HOME CGO_CFLAGS=-I$ORACLE_HOME/sdk/include go"' >> /root/.bashrc
#RUN CGO_LDFLAGS=-L$ORACLE_HOME CGO_CFLAGS=-I$ORACLE_HOME/sdk/include go get gopkg.in/rana/ora.v4

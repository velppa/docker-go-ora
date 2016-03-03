FROM golang:1.6

RUN apt-get update && apt-get -y install zip libaio1

ADD distrib /distrib

RUN unzip /distrib/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /usr/lib/oracle && \
    unzip /distrib/instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /usr/lib/oracle && \
    unzip /distrib/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip -d /usr/lib/oracle

RUN rm -rf /distrib

ENV ORACLE_HOME=/usr/lib/oracle/instantclient_12_1 \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/oracle/instantclient_12_1 \
    PATH=$PATH:/usr/lib/oracle/instantclient_12_1

RUN ln -s $ORACLE_HOME/libclntsh.so.12.1 $ORACLE_HOME/libclntsh.so
    #ln -s $ORACLE_HOME/libclntsh.so.12.1 $ORACLE_HOME/clntsh.so

RUN CGO_LDFLAGS=-L$ORACLE_HOME \
    CGO_CFLAGS=-I$ORACLE_HOME/sdk/include \
    go get gopkg.in/rana/ora.v3

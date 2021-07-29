FROM redhat/ubi8

ARG JAVA_VERSION=8 \
    MAVEN_VERSION=3.8.1

RUN dnf install -y https://cdn.azul.com/zulu/bin/zulu-repo-1.0.0-1.noarch.rpm \
    && dnf -y install zulu8-jdk openssl \
    && dnf -y remove zulu-repo \
    && dnf -y clean all --enablerepo='*' \
    && rm -rf /var/cache/dnf

# /etc/alternatives/jre/lib/security/carerts
COPY ./certificates /tmp/certificates
RUN for certificate_file in $(find /tmp/certificates/*); \
        echo "Now importing certificate: $certificate_file to cacerts..." \
        keytool -import -alias your-alias -keystore cacerts -file $certificate_file \
    done

RUN mkdir -p /usr/share/maven \
    && curl -s https://downloads.apache.org/maven/maven-"$(echo $MAVEN_VERSION | cut -f 1 -d '.')"/$MAVEN_VERSION/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | tar -xvz -C /usr/share/maven --strip 1 \
    && ln -s /usr/share/maven/bin/mvn /etc/alternatives/mvn \
    && ln -s /etc/alternatives/mvn /usr/bin/mvn

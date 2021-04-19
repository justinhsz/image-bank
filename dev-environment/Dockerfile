FROM ubuntu:latest AS vnc
RUN apt update \
    && apt-get install -y curl x11vnc xvfb \
    && apt-get autoremove --purge \
    && apt-get clean
# RUN mkdir ~/.vnc
    # x11vnc -storepasswd $PASSWORD ~/.vnc/passwd

FROM vnc AS idea-slim
ARG INTELLIJ_VERSION=2021.1
COPY ./idea-exclude /tmp/idea-exclude
RUN mkdir -p /opt/idea \
    && curl https://download-cf.jetbrains.com/idea/ideaIC-$INTELLIJ_VERSION.tar.gz | \
       tar -xz -C /opt/idea \
       --strip-components=1 --wildcards \
       --exclude-from="/tmp/idea-exclude" \
    && chmod 777 -R /opt
RUN ln -s /opt/idea/bin/idea.sh /usr/local/bin/idea
CMD idea

FROM idea-slim AS idea-remove-jdk
RUN rm -rf /opt/idea/jbr

FROM vnc AS idea-customize-jdk
COPY --from=idea-remove-jdk /opt/idea /opt/idea
ARG JDK_VERSION=zulu11.45.27-ca-jdk11.0.10
RUN curl https://cdn.azul.com/zulu/bin/${JDK_VERSION}-linux_amd64.deb > /tmp/zulu-jdk.deb \
    && apt install -y /tmp/zulu-jdk.deb \
    && apt-get autoremove --purge \
    && apt-get clean \
    && rm -f /tmp/zulu-jdk.deb
CMD idea
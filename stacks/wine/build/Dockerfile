ARG base_image
FROM ${base_image}

# Install packages that we want to make available at build time
RUN dpkg --add-architecture i386 && apt-get update && \
  apt-get install -y git wget wine-binfmt wine32 wine64 && \
  rm -rf /var/lib/apt/lists/*

COPY ./bin/jq-linux64 /usr/local/bin/jq
COPY ./bin/yj-linux /usr/local/bin/yj

ENV TERM=vt100
COPY --chmod=777 ./bin/lifecycle-wrapper.sh /cnb/lifecycle/creator

# Set required CNB information
ARG stack_id
ENV CNB_STACK_ID=${stack_id}
LABEL io.buildpacks.stack.id=${stack_id}

# Set user and group (as declared in base image)
USER ${CNB_USER_ID}:${CNB_GROUP_ID}

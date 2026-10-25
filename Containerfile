FROM debian:stable-slim AS build

ARG VERSION="v2027.1"
ARG SHA256SUM="d94620344fd9693abecb069616cd473d1ed5895952ee92c645bda6b0fc369ec6"

ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    libarchive-tools \
    && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /build
RUN curl --location "https://github.com/rollerderby/scoreboard/releases/download/$VERSION/crg-scoreboard_$VERSION.zip" -o scoreboard.zip && \
    echo "$SHA256SUM scoreboard.zip" | sha256sum --check && \
    mkdir -p scoreboard/logs && \
    bsdtar --strip-components=1 -xf scoreboard.zip -C scoreboard && \
    find scoreboard -type f -exec chmod -x {} ";" && \
    chmod +x ./scoreboard/scoreboard.sh

# These packages should be instaled from a github release instead from the repo.
WORKDIR /extras

RUN git clone https://github.com/heliogoodbye/Thin-Mint-Announcers-View.git && \
    cp -v Thin-Mint-Announcers-View/announcers.html /build/scoreboard/html/custom/view/announcers.html

RUN git clone https://github.com/heliogoodbye/tmsb.git && \
    rm -rf tmsb/.git && \
    cp -rv tmsb /build/scoreboard/html/custom/overlay/tmsb

# Final container image
FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    default-jre \
    && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /
COPY --from=build /build/scoreboard /scoreboard

ENTRYPOINT ["/scoreboard/scoreboard.sh", "--nogui"]

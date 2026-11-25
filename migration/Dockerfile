# Образ с официальной утилитой Mattermost migration-assist
# (https://github.com/mattermost/migration-assist).
# Собирается из исходников, поэтому работает и на amd64, и на arm64.
FROM golang:1.24-alpine AS build
ARG MIGRATION_ASSIST_VERSION=v0.8
RUN CGO_ENABLED=0 go install \
      github.com/mattermost/migration-assist/cmd/migration-assist@${MIGRATION_ASSIST_VERSION}

FROM alpine:3.20
COPY --from=build /go/bin/migration-assist /usr/local/bin/migration-assist
WORKDIR /work
CMD ["migration-assist", "--help"]

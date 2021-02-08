FROM elixir:1.10 AS builder

ENV MIX_ENV=prod

WORKDIR /app

RUN mix local.rebar --force
RUN mix local.hex --force

COPY . .

RUN mix do deps.get, deps.compile, compile

RUN mkdir -p /opt/release \
  && mix release canvas_app \
  && mv _build/${MIX_ENV}/rel/canvas_app /opt/release

FROM elixir:1.10

WORKDIR /app

RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get install bash

COPY --from=builder /opt/release/canvas_app .

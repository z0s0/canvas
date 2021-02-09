FROM elixir:1.10

WORKDIR /app

RUN mix local.rebar --force
RUN mix local.hex --force

COPY . .

RUN mix deps.get

CMD mix ecto.create && mix run --no-halt

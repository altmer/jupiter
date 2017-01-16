## Jupiter

Jupiter is Elixir-based Openweathermap client.

![screen](https://s27.postimg.org/3n2smwgmr/Jupiter.png)

## Setup

How to run and try out: you only should docker installed to do this.
Just run from the project folder:

```
./build.sh
./run.sh
```

To use working app, go to `localhost:4000`

After that you can start and stop app running `docker stop jupiter` and `docker start jupiter`.

In order to run tests and code linters you need to install elixir (http://elixir-lang.org/install.html)
and nodejs.

Having this installed run:
```
mix deps.get
npm install
# backend tests
mix test
# frontend tests
npm test
```

## Used tools

1. Credo is used for elixir code linting. Run it using `mix credo --strict`.
2. ESLint is used for JS linting (with airbnb config). See linting results (if any) runnning `npm run build`.
3. Backend unit tests are written using ExUnit. Run them with `mix test`.
4. Frontend tests are written with jest. Run them with `npm test`.

## Next steps

1. This application needs proper logging setup (by default phoenix logs everything in stdout).
For production purposes there should be proper logging monitoring too - with Papertrail or ELK stack.
2. For production deploy it is necessary to have docker image running in production (built with elixir release tool like
exrm or distillery). Current docker image is running in development.
3. Caching: I didn't have time yet to implement caching, I would use some elixir solution for this (ConCache for example).
4. There is no routing library on frontend, so it is impossible to share current app state with a link
(I would use react-router for this)
5. Better frontend design.
6. More frontend specs (test interactions) - currently I added only one simple snapshot spec that checks app
rendering without testing any interactions.
7. Add inntegration specs using Hound and Phantomjs.

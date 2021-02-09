### ASCII Canvas

## Tech Stack
* Elixir, PlugCowboy
* Postgres as persistent storage
* React/Antd for simple client

## Design recap

* /core folder contains business logic modules only
* three types of data objects separated by layer definitions. Ecto Schemas on db layer, custom structs on Application layer and API custom structs on HTTP Layer
* Matrix representation— %{{x,y} => value} data structure. Map is backed by HAMT so that it will not be completely reallocated during updates and provice log64(n) complexity on read
* list_of_lists— matrix representation for task checking. This structure is not meant to be used in production-like code
* All app Errors are subtypes of GenError type. 

### Startup

##### Make sure you don't have running services on ports 5000 and 3000 

If you have docker installed just run
`docker-compose build`, `docker-compose up`. It will take some time :). Backend, Frontend and database are connected via docker-compose and you should see client with prepopulated fixture canvases at http://localhost. 
Latest Google Chrome guaranteed. Docker build can fail if you have no space left on device. If build failed please remove some dangling images.
Otherwise 

* Make sure you have postgresql installed(>= 10) guaranteed
* Replace "db" to "localhost" in config/dev.exs
* Run `mix deps.get && mix ecto.create` to create database
* Run `iex -S mix` and http://localhost:5000/drawings should respond with json full of canvases
* Move to client/canvas and install dependencies `yarn`
* Run `yarn start` after that and you should see client on http://localhost:3000
 

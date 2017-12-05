# MongoEcto-Envtest
Ping/Pong Test with Distillery build using ENV Vars: `REPLACE_OS_VARS`, `DB_NAME`, `DB_HOST`, `DB_PORT`, `HOST`,`PORT`

## SETUP MONGO
- In local Mongo (27017) -- Create the db `envtest_prod`
- In db `envtest_prod` create a collection called `pongs` 
- In collection `pongs` create a new document with `count: 10` _or any integer_

## Initial Test: hardcoded DB -- WORKING
#### Step 1: Clone 
- clone down 
- cd in 
- mix deps.get 

#### Step 2: Initial Setup
- Check `config/prod.exs` 
- Leave DB config hardcoded to the following 
```
  database: "envtest_prod",
  hostname: "0.0.0.0",
  port: 27017
```

#### Step 3: Build with Distillery and MIX_ENV 
- Run `mix release.init`
- Run `MIX_ENV=prod mix release --env=prod` _this will hit the prod config_ 
- You should see the following: 
```
==> Release successfully built!
    You can run it in one of the following ways:
      Interactive: _build/prod/rel/envtest/bin/envtest console
      Foreground: _build/prod/rel/envtest/bin/envtest foreground
      Daemon: _build/prod/rel/envtest/bin/envtest start
```

#### Step 4: Run with ENV Vars needed 
- HOST & PORT work correctly and are needed reguardless 
- REPLACE_OS_VARS=true set to use vars passed in
- Run `HOST=localhost PORT=4000 REPLACE_OS_VARS=true _build/prod/rel/envtest/bin/envtest console`
In iex 
- Run `Envtest.Repo.all(Envtest.Ping)`
Should see something simliar to: 
```
[%Envtest.Ping{__meta__: #Ecto.Schema.Metadata<:loaded, "pongs">,
  _id: "5a26a68ee784bde3eff92726", count: 20}]
```

Successful Query Run 

-------------

## With DB ENV Vars -- FAILING 

#### Step 1: Initial Setup
- Swap the DB config to the following: 
```
  database: "${DB_NAME}",
  hostname: "${DB_HOST}",
  port: "${DB_PORT}"
``` 

#### Step 2: Build with Distillery 
- Run `MIX_ENV=prod mix release --env=prod` _this will hit the prod config_ 
- You should see the following: 
```
==> Release successfully built!
    You can run it in one of the following ways:
      Interactive: _build/prod/rel/envtest/bin/envtest console
      Foreground: _build/prod/rel/envtest/bin/envtest foreground
      Daemon: _build/prod/rel/envtest/bin/envtest start
```

#### Step 3: Run with ENV Vars needed 
- Run `HOST=localhost PORT=4000 DB_NAME=envtest_prod DB_HOST=0.0.0.0 DB_PORT=27017 REPLACE_OS_VARS=true _build/prod/rel/envtest/bin/envtest console`

IF ENV vars are off -- Mongo warnings will start to appear with _Not Connected_
IF all ENV vars are correct Application starts as expected 

In iex 
- Run `Envtest.Repo.all(Envtest.Ping)`
Should should see: 
```
[]
```
 
???????????? MER ???????????? No Results... 


## NOTES: 
I've tried passing in ENV vars during the Distillery build as well with the same results 
The end goal will is to have a release that can work dynamically with DB ENV Vars.
If another build tool is known to work and available I am open to suggestions. 









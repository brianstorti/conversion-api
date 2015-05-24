# Conversions API

API to find conversion data in a csv.

#### Setup

Install the dependencies: `bundle install`  
Run the tests: `rake test`  
Check your style: `rake rubocop`  
Setup the database: `rake db:create db:schema:load import_csv`
Run the server: `rackup`  

#### Examples

Searching a conversion value for a specific date:

```bash
$ curl "http://localhost:9292/conversion?metric_id=15&date=2014-07-05"

{ "value": 9 }
```

Searching for a month:

```bash
$ curl "http://localhost:9292/conversion?metric_id=15&month=2014-07"

{ "value": 1 }
```


Searching for a date range:

```bash
$ curl "http://localhost:9292/conversion?metric_id=15&date=2015-04-27&end_date=2015-04-28"

{ "value": 0 }
```

#### Improvements

* I'm just using `sinatra-param`'s default error handling. Ideally I'd like to have better/custom error messages for each problem. (e.g. When a required query param is missing, it just says "Parameter is required".)

* The csv search is very naive. It just loops through each line, sequentially, trying to find a match. This is not really a problem for this small sampling data (`200ms` in the worst case), just it can get embarrassing with a big csv.

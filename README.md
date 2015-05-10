# Conversions API

API to find conversion data in a csv.

#### Setup

Install the dependencies: `bundle install`  
Run the tests: `rake`  
Run the server: `rackup`  

#### Examples

Searching a conversion value for an specific date:

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

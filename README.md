# Conversions API

API to find conversion data in a csv.

#### Setup

Install the dependencies: `bundle install`
Run the tests: `rake`
Run the server: `rackup`

#### Example

```bash
$ curl "http://localhost:9292/conversion?metric_id=15&date=2014-07-05"

{ "value": 9 }
```

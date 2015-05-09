## Goal

Build a RESTful API from the data provided by `metrics_over_time_view.csv`. The dataset is created by another system.
The data provided in this file is only a sampling of data. The full dataset is being withheld. The final data set will also use a csv file.
It is important to note however, that the final dataset, may or may-not be, in a database. This decision has not been made yet, so please make the code easy to change if and when this is needed.

### Fields

* `metric_id`: The id of the metric. A metric is a user created object. e.g. "The number of people who created an account" or "The conversion rate of people who subscribed to our news letter after reading a blog post". 
* `start_date`: The start date represents the beginning of the metric calculation. It is in a custom format (JohnTime) that represents the number of days since Jan 1, 2009.
* `time_range_length`: The number of days in the time range.
* `value`: The metric value.
* `last_calculated_at`: The time at which the metric was calculated. Format: Unix Epoch.
* `end_date`: The end date represents the end of the metric calculation. It is in a custom format that represents the number of days since Jan 1, 2009 (JohnTime).

### metrics_over_time_view.csv (Partial data set)

```
"metric_id","start_date","time_range_length","value","last_calculated_at","end_date"
4,949,1,4,1315325102,949
4,949,7,4,1315325102,955
4,1117,7,1,1329861902,1123
4,942,30,4,1315325102,972
4,1095,30,1,1329861902,1125
15,901,1,2576,1308716102,901
15,902,1,2738,1308803102,902
100,1126,30,175014,1330583101,1154
100,1155,30,160664,1333417201,1185
100,1369,30,153068,1351743302,1399
100,1400,30,190820,1354419602,1429
15,907,1,2832,1309235402,907
```

#### Example Questions a User May Ask

In order to understand how the API could be used, it's important to understand what kind of questions an API consumer could ask.
For easier understanding, Here is an example of a question a consumer would want to know followed by the metric which they would need to interegate. 

* How many users signed up after viewing a blog post on Aug 8, 2011?
  * "Number of people who signed up after viewing blog post" is metric 110.
* During the month of March 2012, how many people purchased something after signing up?
  * "Percentage of people who purchased something after signing up" is metric 120.

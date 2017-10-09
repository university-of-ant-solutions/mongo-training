## Chapter 4: CRUD Optimization

### Optimizing your CRUD Operations

Lecture Notes

You can learn more about optimizing your CRUD operations by visiting the [Create Indexes to Support Your Queries](https://docs.mongodb.com/manual/tutorial/create-indexes-to-support-queries), [Use Indexes to Sort Query Results](https://docs.mongodb.com/manual/tutorial/sort-results-with-indexes), and [Create Queries that Ensure Selectivity](https://docs.mongodb.com/manual/tutorial/create-queries-that-ensure-selectivity) sections of the MongoDB Manual.

What you've learned

- Index selectivity

- Equality, Sort, Range

- Performance Tradeoffs

Question:


When building indexes to service your queries, which of the following is the general rule of thumb you should keep when ordering your index keys? Note, use the following definitions to for this question:

equality: indexed fields on which our queries will do equality matching

range: indexed fields on which our queries will have a range condition

sort: indexed fields on which our queries will sort on

Check all that apply:

- equality, range, sort

- sort, range, equality

- sort, equality, range

- equality, sort, range
TRUE

- range, sort, equality

- range, equality, sort

### Covered Queries

Lecture Notes

You can learn more about covered queries by visiting the [Query Optimization](https://docs.mongodb.com/manual/core/query-optimization/) section of the MongoDB Manual.

You can't cover a query if ...

- Any of the indexed fields are arrays

- Any of the indexed fields are embedded documents

- When run against a mongos if the index does not contain the shard key

Questions:

Given the following indexes:

```
{ _id: 1 }
{ name: 1, dob: 1 }
{ hair: 1, name: 1 }
```

Which of the following queries could be covered by one of the given indexes?

Check all that apply:

db.example.find( { _id : 1117008 }, { _id : 0, name : 1, dob : 1 } )
No, this query would use the _id index, which doesn't match the projected fields.

db.example.find( { name : { $in : [ "Alfred", "Bruce" ] } }, { name : 1, hair : 1 } )
No, this query would use the { name: 1, dob: 1 } index, but it forgets to omit the _id field.

db.example.find( { name : { $in : [ "Bart", "Homer" ] } }, {_id : 0, hair : 1, name : 1} )
No, this query would use the { name: 1, dob: 1 } index, but it is projecting the hair field.

db.example.find( { name : { $in : [ "Bart", "Homer" ] } }, {_id : 0, dob : 1, name : 1} )
Yes, this query would use the { name: 1, dob: 1 } index, which matches the fields in the projection.

### Regex Performance

Utilizing indexes on regex conditions

Given the following index:

> db.products.createIndex({ productName: 1 })

And the following query:

> db.products.find({ productName: /^Craftsman/ })

Which of the following are true?

Check all that apply:

The query will need to do a collection scan.
No, there is an index on productName.

The query will do an index scan.
Yes, there is an index on productName.

The query will likely need to look at all index keys.
No, the use of the caret at the beginning reduces the number of keys examined.

The query would match a productName of "Screwdriver - Craftsman Brand"
No, the query only matches strings that begin with "Craftsman".

### Insert Performance

Lecture Notes

You can learn more about insert performance by visiting the [Write Operation Performance](https://docs.mongodb.com/manual/core/write-performance) section of the MongoDB Manual.

You can download the POCDriver [here](https://github.com/johnlpage/POCDriver).

What you've learned

- Index overhead

- WriteConcern

Questions:

Which of the following decreases the write performance of your MongoDB cluster?

Check all that apply:

Adding indexes.
True

Increasing the number of members we acknowledge writes from.
True

Upgrading to MongoDB 3.4.
False

### Data Type Implications

Why is it important to maintain the same data type for fields across different documents?

Check all that apply:

To avoid application data consistency problems
True

Because it aligns well with cosmetic shapes of documents
False

It's just a best practice; all drivers will deal with data type issues by default
False

It helps to simplify the client application logic
True



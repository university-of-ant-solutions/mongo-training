### Introduction to Indexes

Which of the following statements regarding indexes are true?

- Indexes are used to increase the speed of our queries. (TRUE)
- The _id field is automatically indexed on all collections. (TRUE)
- Indexes reduce the number of documents MongoDB needs to examine to satisfy a query. (TRUE)
- Indexes can decrease write, update, and delete performance.

Index in mongodb is use b-tree data struct.

Lecture Notes

You can learn more about indexes by visiting the Indexes Section of the MongoDB Manual.

### How Data is Stored on Disk

Please, check those options:
  --logpath
  --directoryperdb
  --wiredTigerDirectoryForIndexes

Lecture Notes

You can learn more about how data is stored on disk in MongoDB by visiting the MongoDB Storage FAQ in the MongoDB Manual.

### Single Field Indexes

- Simplest indexes in mongodb
	db.<collection>.createIndex({ <field>: <direction>})
- Key features
    - Key from only one field
    - Can find a single value for the indexed field
    - Can find a range of value
    - Can use dot notation to index fields in sub documents
    - Can be used to find several distinct values in a single query

Lecture Notes

You can learn more about single field indexes by visiting the Single Field Indexes Section of the MongoDB Manual.

Question:

Which of the following queries can use an index on the zip field?

- db.addresses.find( { zip : 55555 } )

- db.addresses.find( { city : "Newark", state : "NJ" } )

- db.addresses.find()

Answer:

The only one that specifies a zip code, db.addresses.find( { zip : 55555 } ), is correct.

The others do not specify a zip code, and so they will not use the index.

### Sorting with Indexes

In this lesson you've learned how to:

- Use indexes to sort
- Use indexes to both match and sort on a single query
- Create indexes that can be used for a combination of ascending and descending sorting orders

Question:

Given the following schema for the products collection:

```
{
  "_id": ObjectId,
  "product_name": String,
  "product_id": String
}
```

And the following index on the products collection:

```
{ product_id: 1 }
```

Which of the following queries will use the given index to perform the sorting of the returned documents?

- db.products.find({}).sort({ "product_id": 1 })
Yes

- db.products.find({}).sort({ "product_id": -1 })
Yes, in this case the index will be traversed backwards for sorting.

- db.products.find({ product_id: '57d7a1' }).sort({ product_id: -1 })
Yes, in this case the index will be used to filter and sort by traversing the index backwards.

- db.products.find({ product_name: 'Soap' }).sort({ product_id: 1 })
Yes, in this case the index will be used to first fetch the sorted documents, and then the server will filter on products that match the product name.

- db.products.find({ product_name: 'Wax' }).sort({ product_name: 1 })
No, there is no index for sorting or filtering. A collection scan and an in-memory sort will be necessary.

### Querying on Compound Indexes

Lecture Notes

You can learn more about compound indexes by visiting the [Compound Indexes](https://docs.mongodb.com/manual/core/index-compound/?jmp=university&_ga=2.110152837.1429391933.1506312426-1040170547.1505831989) and [Create Indexes to Support Your Queries](https://docs.mongodb.com/manual/tutorial/create-indexes-to-support-queries/?jmp=university&_ga=2.83921945.1429391933.1506312426-1040170547.1505831989) sections of the MongoDB Manual.

### When you can sort with Indexes

What we've learned

- We can sort our queries by using index prefixes in our sort predicates

- We can filter and sort queries by splitting up our index prefix between the query and sort predicates.

- We can sort our documents with an index if our sort predicate inverts our index keys or their on of their prefixes.

Questions:

Which of the following statements are true?

- Index prefixes can be used in query predicates to increase index utilization.

- Index prefixes can be used in sort predicates to prevent in-memory sorts.

- We can invert the keys of an index in our sort predicate to utilize an index by walking it backwards.

- It's impossible to have a sorted query use an index for both sorting and filtering.

Answer

It's impossible to have a sorted query use an index for both sorting and filtering.

No, if our sort keys are a non-prefix subset of the index key pattern and the query includes equality conditions on all the prefix keys that precede the sort keys we can use the index for both sorting and filtering.

All of the following are true:

Index prefixes can be used in query predicates to increase index utilization.
Index prefixes can be used in sort predicates to prevent in-memory sorts.
We can invert the keys of an index in our sort predicate to utilize an index by walking it backwards.

### Multikey Indexes

Lecture Notes

You can learn more about multikey indexes by visiting the [Multikey Indexes](https://docs.mongodb.com/manual/core/index-multikey/?jmp=university&_ga=2.75115922.1429391933.1506312426-1040170547.1505831989) section of the MongoDB Manual.

What you've learned

- How to create and use multikey indexes

- The implications of multikey indexes in terms of index size

- The limitations of multikey indexes

Questions:

Given the following index:

```
{ name: 1 emails: 1 }
```

How many index keys will the following document create?

```
{
  "name": "Beatrice McBride",
  "age": 26,
  "emails": [
      "puovvid@wamaw.kp",
      "todujufo@zoehed.mh",
      "fakmir@cebfirvot.pm"
  ]
}
```

Answer

Three is the correct answer. There would be the following index keys:

"Beatrice McBride", "puovvid@wamaw.kp"
"Beatrice McBride", "todujufo@zoehed.mh"
"Beatrice McBride", "fakmir@cebfirvot.pm"

### Partial Indexes

Lecture Notes

You can learn more about partial indexes by visiting the [Partial Indexes](https://docs.mongodb.com/manual/core/index-partial/?jmp=university&_ga=2.75017362.1429391933.1506312426-1040170547.1505831989) section of the MongoDB Manual.

What you've learned

- How to create and use partial indexes

- The advantages and disadvantages of partial indexes

- How to predict when query will ignore the existence of a partial index

- How to emulate a sparse index with a partial index

Question:

Which of the following is true regarding partial indexes?

- Partial indexes represent a superset of the functionality of sparse indexes.

- Partial indexes can be used to reduce the number of keys in an index.

- Partial indexes don't support a uniqueness constraint.

- Partial indexes support compound indexes.

Answer

All of the following are true:

Partial indexes represent a superset of the functionality of sparse indexes.
Partial indexes can be used to reduce the number of keys in an index.
Partial indexes support compound indexes.
The following is not true:

Partial indexes don't support a uniqueness constraint.

No, you can still specify a uniqueness constraint with a partial index. However, uniqueness will be limited to the keys covered by the partial filter expression.

### Collations

Lecture Notes

You can learn more about collations by visiting the [Collations](https://docs.mongodb.com/manual/reference/collation/?jmp=university&_ga=2.87590296.1429391933.1506312426-1040170547.1505831989) section of the MongoDB Manual.

Question:

Which of the following statements are true regarding collations on indexes?

- MongoDB only allows collations to be defined at collection level
false

- Collations allow the creation of case insensitive indexes
true

- Creating an index with a different collation from the base collection implies overriding the base collection collation.
false

- We can define specific collations in an index
true

### Lab 2.1: Using Indexes to Sort Answer 

Given the following index:

```
{"first_name": 1, "address.state": -1, "address.city": -1, "ssn": 1}
```

Which of the following queries are able to use it for both filtering and sorting?

Check all that apply:

- db.people.find({ "first_name": { $gt: "J" } }).sort({ "address.city": -1 })
- db.people.find({ "first_name": "Jessica" }).sort({ "address.state": 1, "address.city": 1 })
- db.people.find({ "first_name": "Jessica", "address.state": { $lt: "S"} }).sort({ "address.state": 1 })
- db.people.find({ "address.city": "West Cindy" }).sort({ "address.city": -1 })
- db.people.find({ "address.state": "South Dakota", "first_name": "Jessica" }).sort({ "address.city": -1 })

The Answer is 2, 3, 5.

1 and 5 doesn't meet index prefix.

### Lab 2.2 

In this lab you're going to examine several example queries and determine which compound index will best service them.

> db.people.find({
    "address.state": "Nebraska",
    "last_name": /^G/,
    "job": "Police officer"
  })

> db.people.find({
    "job": /^P/,
    "first_name": /^C/,
    "address.state": "Indiana"
  }).sort({ "last_name": 1 })

> db.people.find({
    "address.state": "Connecticut",
    "birthday": {
      "$gte": ISODate("2010-01-01T00:00:00.000Z"),
      "$lt": ISODate("2011-01-01T00:00:00.000Z")
    }
  })

If you had to build one index on the people collection, which of the following indexes would best sevice all 3 queries?

Choose the best answer.

Answer:

```
{ "address.state": 1, "job": 1 } - No - As this can able to serve all 3 of the example queries, however a better index that can be used on the first query, and the second query has to do an in-memory sort.

{ "address.state": 1, "job": 1, "first_name": 1 } - No - this index is better than the first, but doesn't help with the sort on the 2nd query.

{ "address.state": 1, "last_name": 1, "job": 1 } - Yes - This is the best one. It index matches the first query, can be used for sorting on the second, and has an prefix for the 3rd query.

{ "job": 1, "address.state": 1 } - No - It can only be used by the first two queries.

{ "job": 1, "address.state": 1, "first_name": 1 } - No - It is better than the previous one, but cannot be used by the 3rd query at all.

{ "job": 1, "address.state": 1, "last_name": 1 } - No - this index has the same issues as the index directly above it.
```


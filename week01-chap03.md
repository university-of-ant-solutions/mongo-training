### Building Indexes

Lecture Notes

You can learn more about building indexes by visiting the [Index Build Operations](https://docs.mongodb.com/manual/core/index-creation) section of the MongoDB Manual.

What you've learned

- Tradeoffs between foreground and background indexes

- How to use background indexes

- Using `currentOp()` and `killOp()`

Question:

Which of the following are true of index build operations?

- Foreground index builds block all reads and writes to the collection being indexed.
True

- Foreground index builds block all reads and writes to the database that holds the collection being indexed.
True

- Background index builds do not impact the query performance of the MongoDB deployment while running.
False

- Background index builds take longer to complete than foreground index builds.
True

- Background index builds block reads and writes to the collection being indexed.
False

### Query Plans

Lecture Notes

You can learn more about query plans by visiting the [Query Plans](https://docs.mongodb.com/manual/core/query-plans/) section of the MongoDB Manual.

What you've learned

- What query plan are

- How the query optimizer works with them

- How they're cached

Question:

Which of the following is/are true concerning query plans?

- MongoDB's query optimizer is statistically based, where collection heuristics are used to determine which plan wins.

No, MongoDB has an empirical query optimizer where query plans are ran against each other during a trial period.

- Query plans are cached so that plans do not need to be generated and compared against each other every time a query is executed.

Yes, that is correct.

- When query plans are generated, for a given query, every index generates at least one query plan.

No, only a subset of the indexes are considered as candidates for planning.

- If an index can't be used, then there is no query plan for that query.

No, if there aren't any viable indexes for a given query, then a COLLSCAN stage will be the main stage of the query plan.

### Understanding Explain

Lecture Notes

You can learn more about explain by watching Charlie Swanson's [Deciphering Explain Output](https://www.mongodb.com/presentations/deciphering-explain-output) talk from MongoDB World.

What you've learned

- What information explain() provides us

- How it works

- What the output looks like in a shareded cluster

- Explain() in MongoDB compass

Question:

With the output of an explain command, what can you deduce?

- The index used by the chosen plan
True

- If a sort was performed by walking the index or done in memory
True

- All the available indexes for this collection
False

- All the different stages the query needs to go through with details about the time it takes, the number of documents processed and returned to the next stage in the pipeline
True

- The estimation of the cardinalities of the distribution of the values
False

### Resource Allocation for Indexes

Lecture Notes

Just to clarify, in this video, when showing monotonically increasing values in an index, the tree is drawn with 0-2 children for any given node. We do not mean to imply that the B-tree is a binary tree. B-trees do not have a fixed ceiling in any node's number of child nodes, and they will typically have more than two. For more information, refer to this [Wikipedia article](https://en.wikipedia.org/wiki/B-tree)

Resource Allocation for Indexes

When dealing with the indexes we can not forget that

1. These data structures requires resources

2. They are part of the database working set

3. We need to take them in consideration in our sizing and maintenace practices

Question:

Which of the following statements apply to index resource allocation?

- For the fastest processing, we should ensure that our indexes fit entirely in RAM
True

- Index information does not need to completely allocated in RAM since MongoDB only uses the right-end-side to the index b-tree, regardless of the queries that use index.
False

- Indexes are not required to be entirely placed in RAM, however performance will be affected by constant disk access to retrieve index information.
True

### Basic Benchmarking

### Lab 3.1: Explain Output

In this lab you're going to determine which index was used to satisfy a query given its explain output.

The following query was ran:

```
> var exp = db.restaurants.explain("executionStats")
> exp.find({ "address.state": "NY", stars: { $gt: 3, $lt: 4 } }).sort({ name: 1 }).hint(REDACTED)
```

Which resulted in the following output:

```
{
  "queryPlanner": {
    "plannerVersion": 1,
    "namespace": "m201.restaurants",
    "indexFilterSet": false,
    "parsedQuery": "REDACTED",
    "winningPlan": {
      "stage": "SORT",
      "sortPattern": {
        "name": 1
      },
      "inputStage": {
        "stage": "SORT_KEY_GENERATOR",
        "inputStage": {
          "stage": "FETCH",
          "inputStage": {
            "stage": "IXSCAN",
            "keyPattern": "REDACTED",
            "indexName": "REDACTED",
            "isMultiKey": false,
            "isUnique": false,
            "isSparse": false,
            "isPartial": false,
            "indexVersion": 1,
            "direction": "forward",
            "indexBounds": "REDACTED"
          }
        }
      }
    },
    "rejectedPlans": [ ]
  },
  "executionStats": {
    "executionSuccess": true,
    "nReturned": 3335,
    "executionTimeMillis": 20,
    "totalKeysExamined": 3335,
    "totalDocsExamined": 3335,
    "executionStages": "REDACTED"
  },
  "serverInfo": "REDACTED",
  "ok": 1
}
```

Given the redacted explain output above, select the index that was passed to hint.

Note: The hint() method is used to force the query planner to select a particular index for a given query. You can learn more about hint by visiting its documentation.

Choose the best answer:
{ "address.state": 1, "name": 1, "stars": 1 }
{ "address.state": 1, "stars": 1, "name": 1 }
{ "address.state": 1, "name": 1 }
{ "address.state": 1 }

The Answer is 2 { "address.state": 1, "stars": 1, "name": 1 }.


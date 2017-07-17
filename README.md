# Inspire Candidate Exercise

At Inspire, much of our day-today work involves authoring and consuming web API endpoints. Typically these endpoints will adhere to REST principles, where context is gathered from the HTTP method and headers used in the request.

We also strive to test all of our code. This repository comes with tests, but they don't yet pass.

Please __send us a zip file of your local fork__ which adds the code necessary to __make all tests pass__. You may feel free to install additional perl modules, but please update the cpanfile with any dependencies, and explain why you chose the given module(s). If any aspect of this exercise is confusing or could be improved, please do add notes to your submission with suggestions.


### Assets provided

#### test.db

SQLite database file containing a single table `wombat` with the following schema and rows:

```sql
TABLE wombat(id integer primary key, name varchar(128), dob date);
```

The `wombat` table contains at least the following three entries:

```
id                 name               dob
-----------------  -----------------  ------------------------------
1                  Alice              1865-11-26
2                  Queen              1951-07-26
3                  Johnny             2010-03-05
```

#### app.psgi

Simple [Plack](https://metacpan.org/pod/Plack) application that returns "Inspire Candidate Exercise" for all urls

#### lib/MiddlewareDB

Plack [Middleware](https://metacpan.org/pod/Plack::Middleware) which exposes an open handle to an ephemeral in-memory database, seeded by the contents of `test.db`. This allows tests to be idempotent without the need for a separate database cleanup step. The database handle will be available to your app as `$env->{dbh}`.

#### t/app.t

A set of tests which the successful candidate will make pass

### Dockerfile

A dockerfile which may optionally be used to establish an environment with the required perl module dependencies

### cpanfile

A [cpanfile](https://metacpan.org/pod/cpanfile) which may optionally be used to establish an environment with the required perl module dependencies.


### Additions needed

The successful applicant will make tests pass by creating a new endpoint `/wombats` which returns all existing wombat entries in JSON format on `GET`, and will create a new wombat entry on `POST`, using two http form variables `name` and `dob`

#### `/wombats` endpoint

   - **GET**

   should return a list serialized in JSON format of all entries in the wombat table, such as:
```json
[
  { "id":1, "name":"Alice", "dob": "1865-11-26" },
  { "id":2, "name":"Queen", "dob": "1951-07-26" },
  { "id":3, "name":"Johnny", "dob": "2010-03-05" },
  ...
]
```

   - **POST**

   should create a new wombat record (based on two variables `name` and `dob`) and return it serialized in JSON form. For simplicity, `name` and `dob` input variables will be provided in the POST body as `application/x-www-form-urlencoded` values.

   - **other HTTP methods**

   All other HTTP methods should return a `405 method not allowed` response

### Solutions confirmed

This exercise is not intended to take an extended amount of time or to be a comprehensive demonstration of a web application. You may opt to add dependencies as you see fit, but please do not attempt to add features or unnecessary complexity. Your changes need to meet only the following requirements:

- `prove -r` should pass all provided tests
- cpanfile should contain any added dependencies
- provide a _brief_ explanation of the reasoning behing your choice of solution and how you might extend the tests or expand functionality over time


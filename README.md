# Species Mapper

This is an app that queries the [GBIF](http://www.gbif.org/) API for information about where species have been seen in the wild and then displays those locations on a map for the user.

This app contains some code that we may want to share across different projects someday: code to query the GBIF API. Let's extract that code into a Ruby gem!

## Guides for Creating Ruby Gems

1. [Ruby Gems](http://guides.rubygems.org/make-your-own-gem/#your-first-gem)

2. [Bundler](http://bundler.io/bundle_gem.html)
 	- Bundler makes gem creation easy by doing some work for us:
 		- Creates the directory structure
 		- Creates the gemspec
 		- Initializes a test suite
 		- Provides helpful Rake tasks

---

## Creating a GbifClient Gem with Bundler

```
bundle gem gbif_client
```

```
cd gbif_client
```

View `README.md` to see what it suggests.

Run to install dependencies:

```
bin/setup
```

Oops, that didn't work! We have some updates to do first. Update the gemspec to remove TODO's, and then retry `bin/setup`.

Excellent.
Now, run:

```
rake spec
```

Oops, red! Let's remove the test failure and re-run `rake spec`.

Now, let's try out the console helper:

```
bin/console
```

---

Write failing tests for GbifClient and run `rake spec`.

Get your tests passing by moving the `GbifClient` code into the `lib/gbif_client.rb` file, as well as the lines to `require 'json'` and `require 'net/http'`.

Your tests should now pass.

Push your shiny new gem to Github!

---

Return to this species mapper project.

Add the new gem to the `Gemfile` and run `bundle install`.

Remove the `GbifApi` class from `app.rb`. Replace with a `require 'gbif_api'` line.

Re-start the app, and see it powered by your new gem!

---

Let’s go back to the gem code and add a new feature. Let's return the dates as part of the `get_species_occurrences` method.

Create a failing test for the new feature (`rake spec`).

Update the `get_species_occurrences` to return a `date` key.

Make sure test now passes (`rake spec`)

Commit!

---

With our new feature in place, let’s bump the gem version!

We are going to use [semantic versioning](http://semver.org/) for this version update.

Update `lib/gbif_api/version.rb`, commit, and push to Github.

Make a Github release.

---

Go back to the species mapper code. Update its `Gemfile` to use the latest and greatest version of the `gbif_client` gem, and run `bundle install`.

---

Congratulations! You are now the proud creator of a fabulous gem.
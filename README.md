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

### Creating and Exploring the Empty Gem

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

### Make Your Gem Do Something!

Write failing tests for the `GbifClient` class and run `rake spec`.

Get your tests passing by moving the `GbifClient` code into the `lib/gbif_client.rb` file, as well as the lines to `require 'json'` and `require 'net/http'`.

Your tests should now pass.

Push your shiny new gem to Github!

---

### Exercise

- Create a gem of your own with `bundle gem <your gem>`
- Update `<your gem>.gemspec` to remove TODOs.
- Create a failing test.
- Add functionality to make your failing test pass.
- Commit & push your gem to GitHub.

---

### Use Your Gem in the Outside World

Return to this species mapper project.

Add the new gem to the `Gemfile` and run `bundle install`.

  - **Hint**: Read [Bundler guide: Gems from Git Repositories](http://bundler.io/git.html) to see how to reference a Git repository.

Remove the `GbifApi` class from `app.rb`. Replace with a `require 'gbif_api'` line.

Re-start the app, and see it powered by your new gem!

---

### Add New Functionality to the Gem

Let’s go back to the gem code and add a new feature. Let's return the dates as part of the `GbifClient#get_species_occurrences` method.

Create a failing test for the new feature.

Update the `GbifClient#get_species_occurrences` to return a `date` key.

  - **Hints**: add `require 'date'` and `result['eventDate'] ? Date.parse(result['eventDate']) : nil`

Make sure test now passes (`rake spec`)

Commit!

---

### Release a New Gem Version

With our new feature in place, let’s bump the gem version!

We are going to use [semantic versioning](http://semver.org/) for this version update.

Update `lib/gbif_api/version.rb`, commit, and push to Github.

Make a Github release.

---

### Exercise

- Add a failing test for some new functionality in your gem.
- Make that new test pass by adding the new functionality.
- Commit and push to GitHub.
- Bump your Gem version, commit, and push to GitHub.
- Create a GitHub release.

---

### Using the New Version in the Outside World

Go back to the species mapper code. Update its `Gemfile` to use the latest and greatest version of the `gbif_client` gem, and run `bundle install`.

  - **Hint**: Read [Bundler guide: Gems from Git Repositories](http://bundler.io/git.html) to see how to reference a specific Git tag.

---

## Congratulations! 🎉

You are now the proud creator of a fabulous gem.
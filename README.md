# `ruby_app_up`
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/jdickey/ruby_app_up?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![GitHub version](https://badge.fury.io/gh/jdickey%2Fruby_app_up.svg)](http://badge.fury.io/gh/jdickey%2Fruby_app_up)
[ ![Codeship Status for jdickey/ruby_app_up](https://codeship.com/projects/ce8a39d0-536d-0132-1cc6-5e1d8dbac3c9/status)](https://codeship.com/projects/48939)
[![Code Climate](https://codeclimate.com/github/jdickey/ruby_app_up/badges/gpa.svg)](https://codeclimate.com/github/jdickey/ruby_app_up)
[![security](https://hakiri.io/github/jdickey/ruby_app_up/master.svg)](https://hakiri.io/github/jdickey/ruby_app_up/master)

`ruby_app_up` is a tool for repeatably setting up an existing Github-based Ruby
(and incidentally Rails) repo for development on a local system. It is a command
line application presently based on [Thor](http://whatisthor.com).

It will:

* Clone a Git repo (from a project identifier you **must** specify;
* EVENTUALLY allow you to select the branch to clone, using the `--branch` command-line option (defaults to `master`);
* EVENTUALLY cloning the repo to the subdirectory specified using the `--clone-to` command-line option (defaults to the default that Git uses, which is normally the bare repo name);
* EVENTUALLY changing to the new project directory;
* EVENTUALLY rebundling the app, bundling into `./vendor` unless the `--no-bundle-vendor` command-line option is specified;
* EVENTUALLY running `bundle package --all`, to cache the app's Gems for faster loading, unless the `--no-package` command line option is specified;
* EVENTUALLY running `rbenv rehash`, to update any Gem-supplied binaries in the `rbenv` load path;
* EVENTUALLY running `RAILS_ENV=test rake db:migrate db:reset db:seed` to initialise and seed the database, unless the `--no-setup-db` command-line option is specified; and finally
* EVENTUALLY running `rake` to run the default Rake task for the project, which normally runs RSpec, Rubocop and similar tools, unless the `--no-rake` command-line option is specified.

## Prerequisites

* Ruby, obviously. This was developed with 2.1.5, but *should* work with any post-2.0 release.
* RubyGems, for the `gem` command.

It installs the `thor` Gem if it's not already on your system. (If you can build a Rails application, you have `thor` installed.) The only other Gem depended on at runtime is the [`github_api`](http://peter-murach.github.io/github/) Gem.

See the `ruby_app_up.gemspec` file for Gems used in development.

## Installation

Install this app via Rubygems:

```
$ gem install ruby_app_up
```

## Configuration

`ruby_app_up` can *optionally* use your GitHub credentials via OAuth2. To use this, first go to the [Applications tab on your GitHub Personal Settings page](https://github.com/settings/applications) and click the [Generate new token](https://github.com/settings/tokens/new) button next to `Personal access tokens`. (You'll be asked to verify your password if you haven't done so recently enough.) Enter a "Token Description", and make sure the boxes for `repo`, `public_repo` and `user` are ticked. Then click the green "Generate Token" button. You'll go back to the "Personal Settings" page, and the new token (a 40-character hexadecimal string) will be highlighted. **KEEP A SAFE RECORD OF THAT NUMBER**; you can't see it again once you leave or refresh the page.

Then, in your Terminal window, set the `OAUTH_TOKEN` environment variable to the token you copied from the GitHub Web page:

```
$ export OAUTH_TOKEN=1234567890abcdef1234567890abcdef90abcdef
```

(using your real value, of course). This should let you access your or your organisation's private repos as well as public ones using `ruby_app_up`.

## Usage

Run `ruby_app_up` with the Github identifier of a project you wish to clone and set up on your local system. For example, to clone [The Next Big Thing](https://github.com/shageman/the_next_big_thing), you would run

```
ruby_app_up shageman/the_next_big_thing
```

This will go through the steps enumerated at the start of this README. Command-line options supported by this tool include:

| Option | Description |
| :----- | :---------- |
| `--branch BRANCHNAME` | Clone the `BRANCHNAME` branch on the repo, rather than the default `master`. |
| `--clone-to TARGET` | Clone the repo into the `TARGET` directory, rather than the Git default (a subdirectory of the current directory, with the name of the project). |
| `--no-bundle-vendor` | Don't bundle Gems into the project's `vendor` subdirectory, but into your system local Gem repository. |
| `--no-setup-db` | Skip running database migration, setup and seeding on the newly-bundled application. |
| `--no-package` | Don't cache the app's Gems for faster loading the next time the `bundle` command is run. |
| `--no-rake` | Don't run the project's `rake` script after cloning and setup is otherwise complete. |

## Contributing

1. Fork it ( https://github.com/jdickey/ruby_app_up/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request. To be accepted, PRs *must* include spec coverage of all new code, and *must* not trigger offences when running `rake rubocop`. *Pull requests not specifying a self-contained branch will be rejected.* (This means "don't make your changes on your copy of `master` or any other existing branch in the upstream repo".)

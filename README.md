# Starling Terminal

Starling Terminal lets you view your [Starling Bank](https://starlingbank.com) statement
right from your terminal. It's built on the open-source
[starling-ruby](https://github.com/timrogers/starling-ruby) library for the
[Starling Bank API](https://developer.starlingbank.com), and is compatible with Ruby 2.4,
Ruby 2.3 and Ruby 2.2.

[![CircleCI](https://circleci.com/gh/timrogers/starling-terminal/tree/master.svg?style=svg)](https://circleci.com/gh/timrogers/starling-terminal/tree/master)
[![Gem Version](https://badge.fury.io/rb/starling_terminal.svg)](https://badge.fury.io/rb/starling_terminal)

## Usage

Install the gem:

```bash
gem install starling_terminal
```

You'll need to get a personal access token for your Starling account. To get set up,
head to the Starling Developers 
["Get Started" page](https://developer.starlingbank.com/get-started) and then scroll
down to the "Personal Access" section for instructions. Set your access token as
the environment variable `$STARLING_ACCESS_TOKEN`.

View your Starling Bank statement from your terminal:

```bash
starling
```

## Tests

The library must pass code checks by RSpec, Rubocop and Reek:

* `bundle exec rspec spec`: checks the library against automated tests we've written
* `bundle exec rubocop`: checks the code against established Ruby code style
* `bundle exec reek lib`: checks the code for "code smells"

As part of our continuous integration (CI) process, we run RSpec, Rubocop and Reek in
CircleCI on Ruby 2.4, Ruby 2.3 and Ruby 2.2. Feel free to push up your branch and open
a pull request to have Circle test your code.

## Contributing

All contributions are welcome - just make a pull request, making sure you include tests
and documentation for any public methods, and write a good, informative commit
message/pull request body.

Check out
[CODE_OF_CONDUCT.md](https://github.com/timrogers/starling-terminal/blob/master/CODE_OF_CONDUCT.md)
to learn about how we can best work together as an open source community to make the
Starling Ruby library as good as it can be.
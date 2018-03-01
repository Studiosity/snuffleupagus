Snuffleupagus
=============

A little simple.. auth token generator

Handles basic time-limited authentication token creation / validation

Uses Gibberish::AES with 256 bit CBC encryption

![Snuffy](/Snuffy.png "Snuffleupagus")

## Installation

Include it in your Gemfile:

```ruby
gem 'snuffleupagus'
```

## Basic Usage

### Token creation

```ruby
snuffy = Snuffleupagus::AuthToken.new('p4ssw0rd')
snuffy.create_token
#=> "53616c7465645f5f25dba4d4a97b238c4560ab46ffdfb77b28ad3e7121ab1917"
```

### Token validation

```ruby
snuffy = Snuffleupagus::AuthToken.new('p4ssw0rd')
snuffy.check_token("53616c7465645f5f25dba4d4a97b238c4560ab46ffdfb77b28ad3e7121ab1917")
#=> true
```

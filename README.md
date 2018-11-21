[![Gem Version](https://badge.fury.io/rb/activerecord-data_integrity.svg)](https://badge.fury.io/rb/activerecord-data_integrity)
[![Build Status](https://travis-ci.org/dsalahutdinov/activerecord-data_integrity.svg?branch=master)](https://travis-ci.org/dsalahutdinov/activerecord-data_integrity.svg?branch=master)

# ActiveRecord::DataIntegrity

Checks your ActiveRecord models to match data integrity principles and rules.
Out of the box it detects many issues such as the lack of foreign keys.

## Intallation
```ruby
group :development do
  ...
  gem 'activerecord-data_integrity', require: false
end
```
## Quickstart

Run `data_integrity` CLI-tool in your Rails project's folder:

```bash
cd ~/amplifr
bundle exec data_integrity
```

It will load the Rails application, check the data integrity issues and give the similar output:
```
BelongsTo/ForeignKey: Label belongs_to project but has no foreign key to projects.id
Accordance/TablePresence: Stat::Hourly has no underlying table hourly_stats
...
```

## Options

Check only specified database rules:
```
  bundle exec data_integrity --only HasMany/ForeignKey,BelongsTo/ForeignKey
```

## Supported Issues

For now tool checks the following issues:
 - [x] The lack of database foreign keys for belongs_to/has_many associations (`HasMany/ForeignKey` and `BelongsTo/ForeignKey` rule)
 - [x] The lack of not-null constraint for the columns with presence validation (`Validation/Presence` rule)
 - [x] Inclusion validated colums should have `enum` data type (`Validation/Inclusion` rule)

## Roadmap (TODO & Help Wanted)

1) Support extra database issues, such as:
 - [ ] presence of `dependend` option set for association and not confliction with underlying `ON DELETE` option of foreign key contraint
 - [ ] check for foreign keys to have bigint data type
 - [ ] presence of index for the foreign keys search
 - [ ] checks for paranoia models and indexes exclusion "removed" rows

2) Config for exluding some rules for the specific models (rubocop like)

3) Autofix for the fixing the issue, mostly by generating safe migrations

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/activerecord-data_integrity.

## Run tests

The easiest way to tests up and running is to use handy [dip](https://github.com/bibendi/dip) gem with Docker and Docker Compose:

```bash
gem install dip
git checkout git@github.com:dsalahutdinov/activerecord-data_integrity.git
cd activerecord-data_integrity
dip provision
dip rspec
```

Otherwise (without Docker) set up environment manually:
```bash
git checkout git@github.com:dsalahutdinov/activerecord-data_integrity.git
cd activerecord-data_integrity
bundle install
bundle appraisal
DB_HOST=localhost DB_NAME=testdb DB_USERNAME=postgres bundle appraisal rspec
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

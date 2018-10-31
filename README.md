# Dbcop

Data integrty analisys cli tool for Rails application.
Out of the box it will enforce many data integrity issus such as the lack of foreign keys.

Supports only Rails 5.2 and PostgSql for now.

## Intallation
```ruby
gem 'dbcop', group: :development
```
## Quickstart
Just type `dbcop` in a Rails project's folder:
```
$ cd my/cool/ruby/project
$ dbcop
```

and you would get someting like this:
```
BelongsTo/ForeignKey: Label belongs_to project but has no foreign key to projects.id
Accordance/TablePresence: Stat::Hourly has no underlying table hourly_stats
...
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dbcop.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

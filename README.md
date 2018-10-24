# Dbcop

Dbcop is the cli tool to analyize the data integrity of your Rails application.
It can automatically find out the lack of foreign keys in the database and many other dismisses.

Add this line to your application's Gemfile:

```ruby
gem 'dbcop', group: :development
```
## Run

Execute:
```bash
bundle exec dbcop
```
and you would get someting like this:
```
'Model User belongs to Account but has no foreign key'
```

Thats will make you be informed of lack of the foreign keys. :)


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dbcop.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

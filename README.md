# YAMLM

Tool to merge multiple YAML files.

## Installation

```sh
$ gem install yamlm
```

## Usage

```
# yamlm <file1.yml> <file2.yml> ...<filen.yml>
$ yamlm original.yml extended.yml
```

original.yml

```
record:
  hoge: &hoge
    id: 1
    name: hoge
    age: 20
```

extended.yml

```
record:
  fuga:
    <<: *hoge
    name: fuga
```

output

```
---
record:
  hoge:
    id: 1
    name: hoge
    age: 20
  fuga:
    id: 1
    name: fuga
    age: 20
```

It must be recognized as a single document when the files are combined.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/yamlm.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

# mumble_counter

mumble_counter intend for providing a users number of mumble server for xfce genmon plugin.

## Installation

1. Clone repo and cd to repo dir.
2. Run `shards install` and `shards build`
3. Copy `./bin/mumble_counter` in `~/.bin` or anywhere you want (Do not forget to edit PATH variable).

## Usage

1. Run command `mumble_counter server=your_mumble_server port=123(port is optional)`.
2. Print full path to binary file `which mumble_counter`
3. Add genmom plugin on panel and set command to `<full path to binary file> server=your_mumble_server`

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/your-github-user/mumble_counter/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Odebe](https://github.com/odebe) - creator and maintainer

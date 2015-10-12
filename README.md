# Margs Util

Some scripts I use, most of them have `--help` if you run them for more options.

## Installation

I symlink to these in my `~/bin/` directory. Maybe I'll package these as a gem? Not sure yet.

## Scripts

- [`extract`](#extract)
- [`gif-overlay`](#gif-overlay)
- [`pretty-json`](#pretty-json)
- [`rack-query`](#rack-query)

### `extract`

Extract input (usually from a log file) into a CSV-like output. Supports grabbing fields by index, or by key in the form `key=value`. Great for parsing logs!

```bash
$ extract --index 1 --key key <<EOS
col0 col1 key=yay bar=nope
woo0 woo1 key=woo
EOS
index_1,key
col1,yay
woo1,woo
```

### `gif-overlay`

Overlays text at the bottom of a GIF. `convert` is just too much to remember on its own.

```bash
gif-overlay --text "THIS IS AWESOME" input.gif output.gif
```

(requires ImageMagick to be installed)


### `pretty-json`

Pretty-prints JSON

```bash
$ pretty-json '{"woo":true}'
{
  "woo": true
}
```


### `rack-query`

Pretty-prints the query part of a URL

```bash
$ rack-query 'https://example.com/foo/bar/baz?x=y&z[]=1&z[]=2#wooo'
https://example.com/foo/bar/baz
{"x"=>"y", "z"=>["1", "2"]}
```

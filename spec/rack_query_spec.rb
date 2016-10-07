require 'spec_helper'
require 'pp'

RSpec.describe 'rack-query' do
  let(:argv) { [] }
  let(:stdin) { nil }

  let(:url) { 'https://example.com/foo/bar/baz?x=y&z[]=1&z[]=2#wooo' }

  let(:pretty_printed) do
    pretty_params = {
      'x' => 'y',
      'z' => [ '1', '2' ]
    }.pretty_inspect

    "https://example.com/foo/bar/baz\n#{pretty_params}"
  end

  context 'with no arguments and no STDIN' do
    subject(:rack_query) { bin('rack-query') }

    it 'prints the usage' do
      expect(rack_query).to include('Usage')
    end
  end

  context 'with a URL in STDIN' do
    let(:stdin) { url }

    subject(:rack_query) { bin('rack-query', stdin: url) }

    it 'parses the URL query and pretty-prints it to stdout' do
      expect(rack_query).to eq(pretty_printed)
    end
  end

  context 'with a URL as an argument' do
    subject(:rack_query) { bin('rack-query', url) }

    it 'parses the URL query and pretty-prints it to stdout' do
      expect(rack_query).to eq(pretty_printed)
    end
  end
end
require 'spec_helper'
require 'json'

RSpec.describe 'pretty-json' do
  let(:argv) { [] }
  let(:stdin) { nil }

  let(:object) { { key: [ 1, 2, 3 ] } }
  let(:json_str) { object.to_json }
  let(:pretty_printed) do
    <<-STR
{
  "key": [
    1,
    2,
    3
  ]
}
    STR
  end

  context 'with no arguments and no STDIN' do
    subject(:pretty_json) { bin('pretty-json') }

    it 'prints the usage' do
      expect(pretty_json).to include('Usage')
    end
  end

  context 'with JSON on STDIN' do
    subject(:pretty_json) { bin('pretty-json', stdin: json_str) }

    it 'pretty-prints the JSON to stdout' do
      expect(pretty_json).to eq(pretty_printed)
    end
  end
end
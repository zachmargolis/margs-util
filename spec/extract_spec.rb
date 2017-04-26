require 'spec_helper'
require 'pp'

RSpec.describe 'extract' do
  let(:argv) { [] }
  let(:stdin) do
    <<-EOS.gsub(/^\s+/, '')
      k1=k1val one two four k2=k2val
      k1=k1val2 one two2 four
    EOS
  end

  subject(:extract) { bin('extract', *argv, stdin: stdin) }

  context 'with a key' do
    let(:argv) { %w(--key k1) }

    it 'generates a CSV with the specified key' do
      expect(extract).to eq <<-EOS.gsub(/^\s+/, '')
        k1
        k1val
        k1val2
      EOS
    end
  end

  context 'with --no-header' do
    let(:argv) { %w(--no-header --key k1) }

    it 'skips the header line when generating a CSV' do
      expect(extract).to eq <<-EOS.gsub(/^\s+/, '')
        k1val
        k1val2
      EOS
    end
  end

  context 'with an --index' do
    let(:argv) { %w(--index 2) }

    it 'generates a CSV with specified index' do
      expect(extract).to eq <<-EOS.gsub(/^\s+/, '')
        index_2
        two
        two2
      EOS
    end
  end

  context 'with a --separator' do
    let(:stdin) do
      <<-EOS.gsub(/^\s+/, '')
        a,b,c,d
        g,h,i,j
      EOS
    end

    let(:argv) { %w(--separator=, --index 0) }

    it 'splits on the custom separator' do
      expect(extract).to eq <<-EOS.gsub(/^\s+/, '')
        index_0
        a
        g
      EOS
    end
  end

  context 'with --after' do
    let(:stdin) do
      <<-EOS.gsub(/^\s+/, '')
        key1 some_useful_val key2 1234
        key1 some_other_useful_val
      EOS
    end

    let(:argv) { %w(--after key1) }

    it 'grabs the space-separted word after' do
      expect(extract).to eq <<-EOS.gsub(/^\s+/, '')
        key1
        some_useful_val
        some_other_useful_val
      EOS
    end
  end
end

require 'spec_helper'
require_relative '../bin/main'

describe 'Main' do
  let(:origin) { 'CNSHA' }
  let(:destination) { 'NLRTM' }
  let(:direct_result) { cheapest_direct(origin, destination) }
  let(:direct_or_indirect_result) { cheapest_direct_or_indirect(origin, destination) }

  context 'success' do
    it 'should return MNOP as shortest direct' do
      expect(direct_result.first[:sailing_code]).to eq 'MNOP'
      expect(direct_result.length).to eq 1
    end

    it 'should return ERXQ and ETRG as shortest direct or indirect' do
      expect(direct_or_indirect_result.map { |sailing| sailing[:sailing_code] }).to eq %w[ERXQ ETRG]
      expect(direct_or_indirect_result.length).to eq 2
    end
  end

  context 'empty' do
    let(:origin) { 'NLRTM' }
    let(:destination) { 'CNSHA' }

    it 'should return []' do
      expect(direct_result).to eq []
      expect(direct_or_indirect_result).to eq []
    end
  end
end

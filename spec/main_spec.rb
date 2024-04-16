require 'spec_helper'
require_relative '../bin/main'

describe 'Main' do
  let(:origin) { 'CNSHA' }
  let(:destination) { 'NLRTM' }
  let(:cheapest_direct_result) { cheapest_direct(origin, destination) }
  let(:cheapest_direct_or_indirect_result) { cheapest_direct_or_indirect(origin, destination) }
  let(:fastest_direct_or_indirect_result) { fastest_direct_or_indirect(origin, destination) }

  context 'success' do
    it 'should return MNOP as the cheapest direct' do
      expect(cheapest_direct_result.first[:sailing_code]).to eq 'MNOP'
      expect(cheapest_direct_result.length).to eq 1
    end

    it 'should return ERXQ and ETRG as the cheapest direct or indirect' do
      expect(cheapest_direct_or_indirect_result.map { |sailing| sailing[:sailing_code] }).to eq %w[ERXQ ETRG]
      expect(cheapest_direct_or_indirect_result.length).to eq 2
    end

    it 'should return QRST as the fastest direct' do
      expect(fastest_direct_or_indirect_result.first[:sailing_code]).to eq 'QRST'
      expect(fastest_direct_or_indirect_result.length).to eq 1
    end
  end

  context 'empty' do
    let(:origin) { 'NLRTM' }
    let(:destination) { 'CNSHA' }

    it 'should return []' do
      expect(cheapest_direct_result).to eq []
      expect(cheapest_direct_or_indirect_result).to eq []
      expect(fastest_direct_or_indirect_result).to eq []
    end
  end
end

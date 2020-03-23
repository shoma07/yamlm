# frozen_string_literal: true

RSpec.describe YAMLM::CLI do
  let(:original_yaml) do
    <<~YAML
      record:
        hoge: &hoge
          id: 1
          name: hoge
          age: 20
    YAML
  end
  let(:extended_yaml) do
    <<~YAML
      record:
        fuga:
          <<: *hoge
          name: fuga
    YAML
  end
  let(:merged_yaml) do
    <<~YAML
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
    YAML
  end

  before do
    allow(File).to receive(:read).with('original.yml').and_return(original_yaml)
    allow(File).to receive(:read).with('extended.yml').and_return(extended_yaml)
  end

  subject do
    -> { described_class.new(['original.yml', 'extended.yml']).execute }
  end

  it { is_expected.to output(merged_yaml).to_stdout }
end

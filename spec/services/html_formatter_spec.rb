require 'rails_helper'

describe HtmlFormatter do
  it 'returns html safe string' do
    expect(described_class.call('hello')).to be_html_safe
  end

  it 'converts markdown to html' do
    expect(described_class.call('*hello*')).to eq '<p><em>hello</em></p>'
  end

  it 'converts :emoji: to unicode emoji' do
    expect(described_class.call('hello :wave:')).to eq '<p>hello 👋</p>'
  end

  it 'sanitizes html' do
    expect(described_class.call("<script>alert('hacked')</script>")).to eq ''
  end
end

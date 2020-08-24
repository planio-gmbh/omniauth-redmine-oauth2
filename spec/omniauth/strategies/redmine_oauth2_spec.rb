require 'spec_helper'

describe OmniAuth::Strategies::RedmineOauth2 do
  let(:access_token) { instance_double('AccessToken', :options => {}, :[] => 'view_issues') }
  let(:parsed_response) { instance_double('ParsedResponse') }
  let(:response) { instance_double('Response', :parsed => parsed_response) }

  let(:redmine_site)          { 'https://some.redmine.com' }

  subject do
    OmniAuth::Strategies::RedmineOauth2.new('REDMINE_KEY', 'REDMINE_SECRET',
        {
            :client_options => {
                :site => redmine_site
            }
        }
    )
  end

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context 'client options' do
    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('/oauth/authorize')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('/oauth/token')
    end

    it 'should have configured site' do
      expect(subject.options.client_options.site).to eq(redmine_site)
    end
  end

  context '#email' do
    it 'should return email from raw_info if available' do
      allow(subject).to receive(:raw_info).and_return({ 'mail' => 'you@example.com' })
      expect(subject.email).to eq('you@example.com')
    end
  end

  context '#raw_info' do
    it 'should use relative paths' do
      expect(access_token).to receive(:get).with('users/current.json').and_return(response)
      expect(subject.raw_info).to eq(parsed_response)
    end

    it 'should use the header auth mode' do
      expect(access_token).to receive(:get).with('users/current.json').and_return(response)
      subject.raw_info
      expect(access_token.options[:mode]).to eq(:header)
    end
  end

  context '#info' do
    it 'should contain email' do
      allow(subject).to receive(:raw_info).and_return({ 'mail' => 'you@example.com' })
      expect(subject.info[:email]).to eq('you@example.com')
    end
    it 'should contain login' do
      allow(subject).to receive(:raw_info).and_return({ 'login' => 'bob' })
      expect(subject.info[:login]).to eq('bob')
    end
  end

  context '#extra.scope' do
    it 'returns the scope on the returned access_token' do
      expect(subject.scope).to eq('view_issues')
    end
  end

  describe '#callback_url' do
    it 'is a combination of host, script name, and callback path' do
      allow(subject).to receive(:full_host).and_return('https://example.com')
      allow(subject).to receive(:script_name).and_return('/sub_uri')

      expect(subject.send :callback_url).to eq('https://example.com/sub_uri/auth/redmine_oauth2/callback')
    end
  end
end


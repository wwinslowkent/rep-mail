require 'spec_helper'
require 'rails_helper'

describe User do
  it { should have_valid(:username).when('Harry Potter', 'Hermione') }
  it { should_not have_valid(:username).when(nil, '') }

  it { should have_valid(:email).when('harry@snape.com', 'hermione@snape.com') }
  it { should_not have_valid(:email).when(nil, '') }

  it 'has a matching password confirmation for the password' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'anotherpassword'
    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end

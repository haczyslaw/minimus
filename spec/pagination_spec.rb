require File.expand_path('../spec_helper.rb',__FILE__)

describe 'Pagination' do

  it 'should have next link on index page' do
    get '/'
    last_response.must_be :ok?
    last_response.body.must_include link_to("/posts?p=2", "Next &raquo;")
  end

  it 'should have prev page on second page' do
    get "/posts?p=2"
    last_response.must_be :ok?
    last_response.body.must_include link_to("/posts?p=1", "&laquo; Prev")
  end

end

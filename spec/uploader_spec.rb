require 'spec_helper'
require 'cloudinary'

describe Cloudinary::Uploader do
  break puts("Please setup environment for api test to run") if Cloudinary.config.api_secret.blank?

  before(:all) do
    @api = Cloudinary::Api
    @uploader_api = Cloudinary::Uploader
  end

  it "should allow tags to be added" do
    @uploader_api.upload("spec/logo.png", :public_id=>"api_add_tag_test", :tags=>"api_test_tag1")
    @uploader_api.add_tag('awesome_tag', ['api_add_tag_test'])
    tags = @api.tags(:public_id => "api_add_tag_test")['tags']
    tags.should include('awesome_tag')
  end
end
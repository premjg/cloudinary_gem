require 'spec_helper'
require 'cloudinary'

describe Cloudinary::Uploader do
  break puts("Please setup environment for api test to run") if Cloudinary.config.api_secret.blank?

  before(:all) do
    @api = Cloudinary::Api
    @uploader_api = Cloudinary::Uploader
    @uploader_api.upload("spec/logo.png", :public_id=>"uploader_test", :tags=>"uploader_test_tag")
  end

  it "should allow tags to be added" do
    @uploader_api.add_tag('awesome_tag', ['uploader_test'])
    tags = @api.tags(:public_id => "uploader_test")['tags']
    tags.should include('awesome_tag')
  end

  it "should allow tags to be removed" do
    @uploader_api.add_tag('removable_awesome_tag', ['uploader_test'])
    @uploader_api.remove_tag('removable_awesome_tag', ['uploader_test'])
    tags = @api.tags(:public_id => "uploader_test")['tags']
    tags.should_not include('removable_awesome_tag')
  end
end
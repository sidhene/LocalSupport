require 'csv'
require 'active_support/all'
require_relative '../../app/models/csv_header'
require_relative '../../app/models/address'
require_relative '../../app/models/description_humanizer'
require_relative '../../app/models/first_capitals_humanizer'
require_relative '../../app/services/create_organisation_from_array'

describe CreateOrganisationFromArray, ".create" do 
  let(:mappings) do 
    {name: 'Title',
     address: 'Contact Address',
     description: 'Activities'}
  end
  let(:headers) do 
    'Title,Charity Number,Activities,Contact Name,Contact Address,website,Contact Telephone,date registered,date removed,accounts date,spending,income,company number,OpenlyLocalURL,twitter account name,facebook account name,youtube account name,feed url,Charity Classification,signed up for 1010,last checked,created at,updated at,Removed?'.split(',')
  end
  let(:fields) do 
    CSV.parse('HARROW BAPTIST CHURCH,1129832,NO INFORMATION RECORDED,MR JOHN ROSS NEWBY,"HARROW BAPTIST CHURCH, COLLEGE ROAD, HARROW, HA1 1BA",http://www.harrow-baptist.org.uk,020 8863 7837,2009-05-27,,,,,,http://OpenlyLocal.com/charities/57879-HARROW-BAPTIST-CHURCH,,,,,"207,305,108,302,306",false,2010-09-20T21:38:52+01:00,2010-08-22T22:19:07+01:00,2012-04-15T11:22:12+01:00,*****')
  end
  let(:row) do 
    CSV::Row.new(headers, fields.flatten)
  end
  let(:validate) { false } 
  let(:organisation_repository) { double :organisation }

  it 'creates and validates an organisation' do 
    allow(organisation_repository).to receive(:find_by_name)
    expect(organisation_repository).to receive(:create_and_validate)
    described_class.create(organisation_repository, row, validate)
  end


end

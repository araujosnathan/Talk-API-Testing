require "httparty"

class TestAPI
  include HTTParty
  base_uri 'http://localhost:3000/api'
end

initial_serie = {
  "genre" => "Action",
  "season" => "5",
  "year" => "2012",
  "name" => "Arrow"
}
response_global = TestAPI.post('/series', body: initial_serie)


RSpec.describe 'API Testing  - GET' do
  it 'Should to return a serie' do

    begin
      response = TestAPI.get('/series/' + response_global["_id"])
      expect(response.code).to eql(200)
      expect(response['name']).to eql(initial_serie['name'])
      expect(response['year']).to eql(initial_serie['year'])
      expect(response['season']).to eql(initial_serie['season'])
      expect(response['genre']).to eql(initial_serie['genre'])
    end
  end
end

RSpec.describe 'API Testing - PUT' do
  it 'Should update a serie' do
    updated_serie = {
      'name' => 'Game of Thrones',
      'year' => '2011',
      'season' => '7',
      'genre' => 'Drama'
    }
    begin
      response = TestAPI.put('/series/' + response_global["_id"], body: updated_serie)
      expect(response.code).to eql(204)

      response = TestAPI.get('/series/' + response_global["_id"])
      expect(response['name']).to eql(updated_serie['name'])
      expect(response['year']).to eql(updated_serie['year'])
      expect(response['season']).to eql(updated_serie['season'])
      expect(response['genre']).to eql(updated_serie['genre'])
    end
  end
end

require 'test_helper'

class GeoLocationsControllerTest < ActionController::TestCase
  setup do
    @geo_location = geo_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:geo_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create geo_location" do
    assert_difference('GeoLocation.count') do
      post :create, geo_location: { lat: @geo_location.lat, locatable_id: @geo_location.locatable_id, locatable_type: @geo_location.locatable_type, long: @geo_location.long, state: @geo_location.state }
    end

    assert_redirected_to geo_location_path(assigns(:geo_location))
  end

  test "should show geo_location" do
    get :show, id: @geo_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @geo_location
    assert_response :success
  end

  test "should update geo_location" do
    put :update, id: @geo_location, geo_location: { lat: @geo_location.lat, locatable_id: @geo_location.locatable_id, locatable_type: @geo_location.locatable_type, long: @geo_location.long, state: @geo_location.state }
    assert_redirected_to geo_location_path(assigns(:geo_location))
  end

  test "should destroy geo_location" do
    assert_difference('GeoLocation.count', -1) do
      delete :destroy, id: @geo_location
    end

    assert_redirected_to geo_locations_path
  end
end

require 'test_helper'

class ContractorsControllerTest < ActionController::TestCase
  setup do
    @contractor = contractors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contractors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contractor" do
    assert_difference('Contractor.count') do
      post :create, contractor: { address1: @contractor.address1, address2: @contractor.address2, city: @contractor.city, cont_id: @contractor.cont_id, email: @contractor.email, firstname: @contractor.firstname, lastname: @contractor.lastname, phone: @contractor.phone, startdate: @contractor.startdate, state: @contractor.state, updated: @contractor.updated, zip: @contractor.zip }
    end

    assert_redirected_to contractor_path(assigns(:contractor))
  end

  test "should show contractor" do
    get :show, id: @contractor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contractor
    assert_response :success
  end

  test "should update contractor" do
    patch :update, id: @contractor, contractor: { address1: @contractor.address1, address2: @contractor.address2, city: @contractor.city, cont_id: @contractor.cont_id, email: @contractor.email, firstname: @contractor.firstname, lastname: @contractor.lastname, phone: @contractor.phone, startdate: @contractor.startdate, state: @contractor.state, updated: @contractor.updated, zip: @contractor.zip }
    assert_redirected_to contractor_path(assigns(:contractor))
  end

  test "should destroy contractor" do
    assert_difference('Contractor.count', -1) do
      delete :destroy, id: @contractor
    end

    assert_redirected_to contractors_path
  end
end

require "application_system_test_case"

class RecordsTest < ApplicationSystemTestCase
  setup do
    @record = records(:one)
  end

  test "visiting the index" do
    visit records_url
    assert_selector "h1", text: "Records"
  end

  test "creating a Record" do
    visit records_url
    click_on "New Record"

    fill_in "Content", with: @record.content
    fill_in "Domain", with: @record.domain_id
    fill_in "Host", with: @record.host
    fill_in "Ttl", with: @record.ttl
    fill_in "Type", with: @record.record_type
    click_on "Create Record"

    assert_text "Record was successfully created"
    click_on "Back"
  end

  test "updating a Record" do
    visit records_url
    click_on "Edit", match: :first

    fill_in "Content", with: @record.content
    fill_in "Domain", with: @record.domain_id
    fill_in "Host", with: @record.host
    fill_in "Ttl", with: @record.ttl
    fill_in "Type", with: @record.record_type
    click_on "Update Record"

    assert_text "Record was successfully updated"
    click_on "Back"
  end

  test "destroying a Record" do
    visit records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Record was successfully destroyed"
  end
end

*** Settings ***
Documentation            Robot Framework tests to verify the features of the Swags Lab demo site.

Library                  Browser
Library                  String
Library                  Collections

Resource                 test_login${/}login_test.resource 
Resource                 suite_management${/}browser_login.resource
Resource                 test_sorting${/}sorting_test.resource

Suite Setup              browser_login.Web page should open successfully    ${URL}
Suite Teardown           Browser.Close Browser    browser=ALL


*** Variables ***
${URL}                   https://www.saucedemo.com/


*** Test Cases ***
Login test should succeed
    login_test.Login button should exist
    login_test.Error message should be visible for empty username & password
    login_test.Login test using available usernames/passwords

Sorting test should succeed
    sorting_test.Verify Low to high price sorting
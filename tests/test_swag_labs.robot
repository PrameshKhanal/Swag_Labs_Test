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
    login_test.Verify Login button
    login_test.Verify Empty Credentials Login
    login_test.Verify Valid Credentials Login

Sorting test should succeed
    sorting_test.Verify Low To High Sorting
    sorting_test.Verify High To Low Sorting
*** Settings ***
Documentation            Robot Framework tests to verify the features of the Swags Lab demo site.

Library                  Browser

Resource                 ../resources/browser_login.resource
Resource                 ../resources/manage_screenshots.resource

Suite Setup              browser_login.Web page should open successfully    ${URL}
Suite Teardown           Browser.Close Browser    browser=ALL


*** Variables ***
${URL}                   https://www.saucedemo.com/
${SCREENSHOTPATH}        C:/Development/robot-scripts/Swag_Labs_Test/screenshots


*** Test Cases ***
Verify Login button
    [Documentation]                                This test case will verify that the Login button is not disabled and after verification,
    ...                                            this test case will take the screenshot of the Login button.
    [Tags]                                         loginButtonTest
    Browser.Get Attribute                          id=login-button
    ...                                            attribute=aria-disabled    
    ...                                            assertion_operator=should be    
    ...                                            assertion_expected=${None}
    manage_screenshots.Take selector Screenshot    login_test    id=login-button
    
*** Keywords ***
